function Test-MedProInstalled {
    <#
    .SYNOPSIS
        Checks whether an application is already present, using its detect rule.

    .DESCRIPTION
        Re-running the installer for software that is already there wastes a
        technician's time and, for some vendors, downgrades a newer version to
        whatever the catalog link points at.

        A detect rule is either a registry path or a file path. Environment
        variables in it are expanded, so a catalog entry can say
        "%ProgramFiles%\Vendor\app.exe" without knowing the drive layout.

    .PARAMETER Detect
        Registry path (HKLM:\..., HKCU:\...) or a file system path.

    .OUTPUTS
        [bool] True if the application appears to be installed.

    .EXAMPLE
        Test-MedProInstalled -Detect "HKLM:\SOFTWARE\Google\Chrome"
        Test-MedProInstalled -Detect "%ProgramFiles%\7-Zip\7z.exe"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]$Detect
    )

    if ([string]::IsNullOrWhiteSpace($Detect)) { return $false }

    $expanded = [System.Environment]::ExpandEnvironmentVariables($Detect)

    try {
        return [bool](Test-Path -Path $expanded -ErrorAction SilentlyContinue)
    } catch {
        return $false
    }
}
