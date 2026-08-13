function Invoke-MedProSelectRecommendedAppsButton {
    <#
    .SYNOPSIS
        Ticks the app groups MedPro removes from every workstation.

    .DESCRIPTION
        Bound to MedProSelectRecommendedAppsButton. Ticks every group marked
        "recommended": true and leaves anything marked caution alone - the
        OEM group in particular matches loosely enough that it should be a
        deliberate choice, not part of a one-click default.
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.DebloatCheckBoxes -or $sync.DebloatCheckBoxes.Count -eq 0) { return }

    $count = 0
    foreach ($name in $sync.DebloatCheckBoxes.Keys) {
        $group = $sync.configs.debloat.groups.$name
        $isRecommended = ($group.recommended -eq $true) -and ($group.caution -ne $true)

        $sync.DebloatCheckBoxes[$name].IsChecked = $isRecommended
        if ($isRecommended) { $count++ }
    }

    Write-MedProLog "Selected the $count app groups MedPro removes from a standard workstation."
}
