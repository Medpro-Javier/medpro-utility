function Install-MedProWinget {
    <#
    .SYNOPSIS
        Makes sure winget is available, installing App Installer if it is not.

    .DESCRIPTION
        winget is the fallback path for every application in the catalog, so it
        needs to work even on an image where it does not. Two cases are common:

          - A freshly imaged machine where App Installer has not yet been
            provisioned for the signed-in user. Re-registering the existing
            package fixes this without a download.
          - An LTSC or heavily stripped image with no App Installer at all,
            where the package and its dependencies have to be fetched.

        The result is cached on $sync for the session, because probing this on
        every application in a fifteen-app run is wasted time.

    .OUTPUTS
        [bool] Whether winget can be used.

    .EXAMPLE
        if (Install-MedProWinget) { winget install --id Google.Chrome }
    #>
    [CmdletBinding()]
    param()

    if ($null -ne $sync.WingetAvailable) { return $sync.WingetAvailable }

    if (Get-Command winget.exe -ErrorAction SilentlyContinue) {
        $sync.WingetAvailable = $true
        return $true
    }

    Write-MedProLog "winget was not found - trying to enable it..." -Level Warning

    # Cheapest fix first: the package is present but not registered for this user.
    try {
        $appInstaller = Get-AppxPackage -Name "Microsoft.DesktopAppInstaller" -ErrorAction SilentlyContinue
        if ($appInstaller) {
            Add-AppxPackage -DisableDevelopmentMode -Register `
                "$($appInstaller.InstallLocation)\AppXManifest.xml" -ErrorAction Stop
            if (Get-Command winget.exe -ErrorAction SilentlyContinue) {
                Write-MedProLog "winget re-registered." -Level Success
                $sync.WingetAvailable = $true
                return $true
            }
        }
    } catch {
        Write-MedProLog "  could not re-register App Installer - $($_.Exception.Message)" -Level Warning
    }

    # Otherwise fetch it. The two framework packages are dependencies App
    # Installer will not start without on a stripped image.
    $packages = @(
        @{ Name = "VCLibs.appx";      Url = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx" },
        @{ Name = "UIXaml.appx";      Url = "https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx" },
        @{ Name = "AppInstaller.msixbundle"; Url = "https://aka.ms/getwinget" }
    )

    foreach ($package in $packages) {
        $path = Get-MedProDownload -Url $package.Url -FileName $package.Name
        if (-not $path) {
            Write-MedProLog "Could not download $($package.Name). winget will not be available as a fallback." -Level Error
            $sync.WingetAvailable = $false
            return $false
        }

        try {
            Add-AppxPackage -Path $path -ErrorAction Stop
        } catch {
            # A dependency that is already present at a newer version reports a
            # failure here, which is not a problem worth stopping for.
            Write-MedProLog "  $($package.Name) - $($_.Exception.Message)" -Level Warning
        }
    }

    $available = [bool](Get-Command winget.exe -ErrorAction SilentlyContinue)
    if ($available) {
        Write-MedProLog "winget installed." -Level Success
    } else {
        Write-MedProLog "winget is still unavailable. Applications without a working download link will be skipped." -Level Error
    }

    $sync.WingetAvailable = $available
    return $available
}
