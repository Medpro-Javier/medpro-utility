function Invoke-MedProSelectStandardAppsButton {
    <#
    .SYNOPSIS
        Ticks the applications that go on every MedPro workstation.

    .DESCRIPTION
        Bound to MedProSelectStandardAppsButton. Ticks every catalog entry marked
        "standard": true - the MedPro base image software list, as opposed to
        role-specific software a technician adds deliberately.
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.InstallCheckBoxes -or $sync.InstallCheckBoxes.Count -eq 0) { return }

    $count = 0
    foreach ($name in $sync.InstallCheckBoxes.Keys) {
        $isStandard = $sync.configs.applications.$name.standard -eq $true
        $sync.InstallCheckBoxes[$name].IsChecked = $isStandard
        if ($isStandard) { $count++ }
    }

    Write-MedProLog "Selected the $count applications in the MedPro standard build."
}
