function Add-MedProDebloatControls {
    <#
    .SYNOPSIS
        Builds the Debloat tab from config/debloat.json.

    .DESCRIPTION
        Apps are grouped rather than listed one package at a time. A technician
        should be deciding "does this machine need Xbox", not ticking eight
        separate Xbox package names and hoping they got them all.

        The keep-list count is surfaced in the log at startup so it is obvious
        that a guard exists and roughly how much it covers.

    .EXAMPLE
        Add-MedProDebloatControls
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.MedProDebloatPanel) { return }

    $sync.DebloatCheckBoxes = @{}
    $entries = Get-MedProConfigEntries -Config $sync.configs.debloat.groups

    if ($entries.Count -eq 0) {
        Write-MedProLog "No debloat groups are defined in config/debloat.json." -Level Warning
        return
    }

    $categories = Add-MedProCheckBoxCards -Panel $sync.MedProDebloatPanel `
                                          -Entries $entries `
                                          -ControlSet $sync.DebloatCheckBoxes

    $keepCount = @($sync.configs.debloat.keepList).Count
    Write-MedProLog "Loaded $($entries.Count) debloat groups across $categories categories. $keepCount package patterns are protected by the keep-list."
}
