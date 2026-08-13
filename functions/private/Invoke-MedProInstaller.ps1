function Invoke-MedProInstaller {
    <#
    .SYNOPSIS
        Runs a local installer file silently and returns its exit code.

    .DESCRIPTION
        The execution half of Install-MedProProgram, kept separate so that a
        file from a share and a file from a vendor URL run through exactly the
        same code once they are on disk.

        Throws if the installer cannot be started at all. Returns the exit code
        otherwise - deciding which codes mean success is the caller's job, because
        3010 and 1641 mean "worked, needs a reboot" rather than "failed".

    .PARAMETER InstallerPath
        Local path to the installer.

    .PARAMETER Type
        msi, msix, appx, or exe.

    .PARAMETER Arguments
        Silent-install switches. Falls back to a sensible default per type.

    .OUTPUTS
        [int] The installer's exit code.

    .EXAMPLE
        Invoke-MedProInstaller -InstallerPath $file -Type "msi" -Arguments "/qn /norestart"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$InstallerPath,
        [Parameter(Mandatory)][string]$Type,
        [AllowEmptyString()][string]$Arguments
    )

    switch ($Type.ToLower()) {

        "msi" {
            $switches = if ($Arguments) { $Arguments } else { "/qn /norestart" }
            # The path is quoted because MedPro's share paths contain spaces.
            $process = Start-Process -FilePath "msiexec.exe" `
                                     -ArgumentList "/i `"$InstallerPath`" $switches" `
                                     -Wait -PassThru -ErrorAction Stop
            return $process.ExitCode
        }

        { $_ -in @("msix", "appx", "msixbundle") } {
            Add-AppxProvisionedPackage -Online -PackagePath $InstallerPath -SkipLicense -ErrorAction Stop | Out-Null
            return 0
        }

        default {
            $switches = if ($Arguments) { $Arguments } else { "/S" }

            # Start-Process rejects an empty argument list, and a few installers
            # take no switches at all.
            if ([string]::IsNullOrWhiteSpace($switches)) {
                $process = Start-Process -FilePath $InstallerPath -Wait -PassThru -ErrorAction Stop
            } else {
                $process = Start-Process -FilePath $InstallerPath -ArgumentList $switches -Wait -PassThru -ErrorAction Stop
            }
            return $process.ExitCode
        }
    }
}
