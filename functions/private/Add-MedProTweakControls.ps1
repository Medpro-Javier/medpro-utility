function Add-MedProTweakControls {
    <#
    .SYNOPSIS
        Builds the Tweaks tab from config/tweaks.json.

    .DESCRIPTION
        Nothing about the Tweaks tab is hard-coded in the XAML. Adding a tweak to
        the config and rebuilding is all it takes to make it appear here.

    .EXAMPLE
        Add-MedProTweakControls
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.MedProTweaksPanel) { return }

    $sync.TweakCheckBoxes = @{}
    $entries = Get-MedProConfigEntries -Config $sync.configs.tweaks

    if ($entries.Count -eq 0) {
        Write-MedProLog "No tweaks are defined in config/tweaks.json." -Level Warning
        return
    }

    $categories = Add-MedProCheckBoxCards -Panel $sync.MedProTweaksPanel `
                                          -Entries $entries `
                                          -ControlSet $sync.TweakCheckBoxes

    Write-MedProLog "Loaded $($entries.Count) tweaks across $categories categories."
}
