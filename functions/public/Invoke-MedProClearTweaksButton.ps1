function Invoke-MedProClearTweaksButton {
    <#
    .SYNOPSIS
        Unticks every tweak checkbox.

    .DESCRIPTION
        Bound to MedProClearTweaksButton. Clearing the selection is the fastest
        way out of a half-made choice, and it costs nothing to offer.
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.TweakCheckBoxes) { return }

    foreach ($name in $sync.TweakCheckBoxes.Keys) {
        $sync.TweakCheckBoxes[$name].IsChecked = $false
    }

    Write-MedProLog "Selection cleared."
}
