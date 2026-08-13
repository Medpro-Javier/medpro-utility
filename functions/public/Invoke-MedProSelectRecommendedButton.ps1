function Invoke-MedProSelectRecommendedButton {
    <#
    .SYNOPSIS
        Ticks the tweaks MedPro IT applies to every workstation.

    .DESCRIPTION
        Bound to MedProSelectRecommendedButton. Ticks every tweak whose config
        entry carries "recommended": true, which is how the standard MedPro
        workstation build is expressed.

        Anything marked caution is deliberately left unticked - the recommended
        set is the one a technician can apply without thinking, so it must not
        contain a choice that needs thinking about.
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.TweakCheckBoxes -or $sync.TweakCheckBoxes.Count -eq 0) { return }

    $count = 0
    foreach ($name in $sync.TweakCheckBoxes.Keys) {
        $tweak = $sync.configs.tweaks.$name
        $isRecommended = ($tweak.recommended -eq $true) -and ($tweak.caution -ne $true)

        $sync.TweakCheckBoxes[$name].IsChecked = $isRecommended
        if ($isRecommended) { $count++ }
    }

    Write-MedProLog "Selected the $count recommended tweaks for a standard MedPro workstation."
}
