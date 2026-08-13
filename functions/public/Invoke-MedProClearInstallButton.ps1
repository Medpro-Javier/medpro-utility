function Invoke-MedProClearInstallButton {
    <#
    .SYNOPSIS
        Unticks every application on the Install tab.

    .DESCRIPTION
        Bound to MedProClearInstallButton.
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.InstallCheckBoxes) { return }

    foreach ($name in $sync.InstallCheckBoxes.Keys) {
        $sync.InstallCheckBoxes[$name].IsChecked = $false
    }

    Write-MedProLog "Application selection cleared."
}
