function Add-MedProPresetControls {
    <#
    .SYNOPSIS
        Fills the preset dropdown in the header from config/preset.json.

    .DESCRIPTION
        Each item carries its config key in .Tag and its description in .ToolTip,
        so a technician can hover to see what a preset actually covers before
        choosing it.

    .EXAMPLE
        Add-MedProPresetControls
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.MedProPresetCombo) { return }

    $presets = Get-MedProConfigEntries -Config $sync.configs.preset
    $sync.MedProPresetCombo.Items.Clear()

    if ($presets.Count -eq 0) {
        $sync.MedProPresetCombo.IsEnabled = $false
        return
    }

    foreach ($preset in $presets) {
        $item = New-Object System.Windows.Controls.ComboBoxItem
        $item.Content = $preset.Value.content
        $item.Tag     = $preset.Name
        if ($preset.Value.description) { $item.ToolTip = $preset.Value.description }
        [void]$sync.MedProPresetCombo.Items.Add($item)
    }

    Write-MedProLog "Loaded $($presets.Count) presets."
}
