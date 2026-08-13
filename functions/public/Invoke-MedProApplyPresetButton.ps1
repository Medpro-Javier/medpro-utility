function Invoke-MedProApplyPresetButton {
    <#
    .SYNOPSIS
        Ticks everything a preset covers across the Install, Tweaks, and Debloat tabs.

    .DESCRIPTION
        Bound to MedProApplyPresetButton.

        A preset selects; it does not execute. The technician still reviews each
        tab and presses its own action button. That is deliberate - installing
        software, changing system settings, and permanently removing apps should
        not all happen from one click on a dropdown, and a technician who cannot
        see what a preset chose cannot catch the case where it is wrong for the
        machine in front of them.

        A preset naming a key that no longer exists in the configs is reported
        rather than skipped, because that means the preset has drifted out of
        date and will quietly under-provision every machine it touches.
    #>
    [CmdletBinding()]
    param()

    $selected = $sync.MedProPresetCombo.SelectedItem
    if (-not $selected) {
        Write-MedProLog "Choose a preset first." -Level Warning
        return
    }

    # The key travels on the item's Tag so the display name can change freely.
    $presetKey = $selected.Tag
    $preset    = $sync.configs.preset.$presetKey

    if (-not $preset) {
        Write-MedProLog "Preset '$presetKey' is missing from config/preset.json." -Level Error
        return
    }

    Write-MedProLog "Applying preset: $($preset.content)"

    $stale = New-Object System.Collections.Generic.List[string]

    $targets = @(
        @{ Keys = @($preset.applications); Controls = $sync.InstallCheckBoxes; Label = "applications" },
        @{ Keys = @($preset.tweaks);       Controls = $sync.TweakCheckBoxes;   Label = "tweaks" },
        @{ Keys = @($preset.debloat);      Controls = $sync.DebloatCheckBoxes; Label = "app groups to remove" }
    )

    foreach ($target in $targets) {
        if (-not $target.Controls) { continue }

        # Clear first so switching presets replaces the selection rather than
        # accumulating on top of whatever was ticked before.
        foreach ($name in $target.Controls.Keys) { $target.Controls[$name].IsChecked = $false }

        $ticked = 0
        foreach ($key in $target.Keys) {
            if ($target.Controls.ContainsKey($key)) {
                $target.Controls[$key].IsChecked = $true
                $ticked++
            } else {
                $stale.Add("$key (in $($target.Label))")
            }
        }

        Write-MedProLog "  $ticked $($target.Label) selected"
    }

    foreach ($missing in $stale) {
        Write-MedProLog "  preset refers to '$missing', which no longer exists in the configs." -Level Warning
    }

    Write-MedProLog "Review each tab, then use its own button to apply. Nothing has been changed yet." -Level Success
}
