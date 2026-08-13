function Invoke-MedProPowerProfileButton {
    <#
    .SYNOPSIS
        Applies the MedPro standard power plan and screen-lock policy.

    .DESCRIPTION
        Bound to MedProPowerProfileButton. Fast enough to run on the UI thread.
    #>
    [CmdletBinding()]
    param()

    Set-MedProUIState -Enabled $false -Status "Applying the power profile..."

    try {
        Write-MedProLog "Applying the MedPro power profile..."
        $success = Set-MedProPowerProfile

        if ($success) {
            Write-MedProLog "Power profile applied." -Level Success
        } else {
            Write-MedProLog "Power profile applied with warnings - check the lines above." -Level Warning
        }
    } finally {
        Set-MedProUIState -Enabled $true -Status "Ready"
    }
}
