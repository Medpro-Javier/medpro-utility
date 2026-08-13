function Invoke-MedProClearAppsButton {
    <#
    .SYNOPSIS
        Unticks every app group on the Debloat tab.

    .DESCRIPTION
        Bound to MedProClearAppsButton. Given what the Remove button does, an
        obvious way to abandon a half-made selection is worth having.
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.DebloatCheckBoxes) { return }

    foreach ($name in $sync.DebloatCheckBoxes.Keys) {
        $sync.DebloatCheckBoxes[$name].IsChecked = $false
    }

    Write-MedProLog "App selection cleared."
}
