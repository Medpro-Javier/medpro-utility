function Set-MedProService {
    <#
    .SYNOPSIS
        Changes a Windows service's startup type.

    .DESCRIPTION
        A service that is not present on this machine is not an error - Windows 11
        SKUs and feature states vary, and a missing service simply means the tweak
        has nothing to do here. Anything else is reported and the batch continues.

        Startup type is changed but running services are deliberately not stopped.
        Killing a service out from under a logged-in session is how a "performance
        tweak" turns into a support ticket; the new startup type takes effect on
        the next reboot, which is what the tool tells the technician to do anyway.

    .PARAMETER Name
        Service short name, e.g. "DiagTrack".

    .PARAMETER StartupType
        Automatic, AutomaticDelayedStart, Manual, or Disabled.

    .EXAMPLE
        Set-MedProService -Name "DiagTrack" -StartupType Disabled
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Name,

        [Parameter(Mandatory)]
        [ValidateSet("Automatic", "AutomaticDelayedStart", "Manual", "Disabled")]
        [string]$StartupType
    )

    $service = Get-Service -Name $Name -ErrorAction SilentlyContinue
    if (-not $service) {
        Write-MedProLog "  service '$Name' is not present on this machine - skipped."
        return $true
    }

    try {
        if ($StartupType -eq "AutomaticDelayedStart") {
            # Set-Service has no delayed-start option, so this drops to sc.exe.
            $result = & sc.exe config $Name start= delayed-auto 2>&1
            if ($LASTEXITCODE -ne 0) { throw "sc.exe returned $LASTEXITCODE - $result" }
        } else {
            Set-Service -Name $Name -StartupType $StartupType -ErrorAction Stop
        }

        Write-MedProLog "  service $Name -> $StartupType"
        return $true

    } catch {
        Write-MedProLog "  could not change service $Name - $($_.Exception.Message)" -Level Warning
        return $false
    }
}
