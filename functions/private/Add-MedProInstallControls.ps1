function Add-MedProInstallControls {
    <#
    .SYNOPSIS
        Builds the Install tab from config/applications.json.

    .DESCRIPTION
        One card per category, one checkbox per application. Adding software to
        the MedPro suite means editing one JSON file and rebuilding - no
        PowerShell required, which is the point.

        Entries with no winget fallback are worth knowing about, so the count is
        surfaced at startup: those are the ones where a dead vendor link means a
        failed install rather than a slightly different version.

    .EXAMPLE
        Add-MedProInstallControls
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.MedProInstallPanel) { return }

    $sync.InstallCheckBoxes = @{}
    $entries = Get-MedProConfigEntries -Config $sync.configs.applications

    if ($entries.Count -eq 0) {
        Write-MedProLog "No applications are defined in config/applications.json." -Level Warning
        return
    }

    $categories = Add-MedProCheckBoxCards -Panel $sync.MedProInstallPanel `
                                          -Entries $entries `
                                          -ControlSet $sync.InstallCheckBoxes

    $noFallback = @($entries | Where-Object { -not $_.Value.winget }).Count

    $message = "Loaded $($entries.Count) applications across $categories categories."
    if ($noFallback -gt 0) {
        $message += " $noFallback have no winget fallback and depend on their download link working."
    }
    Write-MedProLog $message
}
