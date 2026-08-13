function New-MedProRestorePoint {
    <#
    .SYNOPSIS
        Creates a system restore point before the tool changes anything.

    .DESCRIPTION
        This is the safety net the whole Tweaks tab rests on. It runs before any
        batch of tweaks is applied, so a technician always has a way back even if
        an individual tweak's undo turns out to be incomplete.

        Two obstacles are handled:

        - System Protection is off by default on many OEM Windows 11 images, so
          it is enabled on the system drive first.
        - Windows silently refuses to create more than one restore point in a
          24-hour window. The frequency limit is lifted so a technician doing two
          runs on one machine still gets two checkpoints.

    .PARAMETER Description
        Label shown in the System Restore UI.

    .OUTPUTS
        [bool] Whether a restore point now exists for this run.

    .EXAMPLE
        New-MedProRestorePoint -Description "MedPro Utility - before tweaks"
    #>
    [CmdletBinding()]
    param(
        [string]$Description = "MedPro Utility"
    )

    Write-MedProLog "Creating a system restore point..."

    try {
        Enable-ComputerRestore -Drive "$env:SystemDrive\" -ErrorAction Stop
    } catch {
        Write-MedProLog "Could not enable System Protection: $($_.Exception.Message)" -Level Warning
    }

    # Without this, a second run in the same day silently produces no checkpoint.
    $frequencyKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore"
    $frequencyRestored = $false
    try {
        if (-not (Test-Path -LiteralPath $frequencyKey)) {
            New-Item -Path $frequencyKey -Force | Out-Null
        }
        Set-ItemProperty -LiteralPath $frequencyKey -Name "SystemRestorePointCreationFrequency" -Type DWord -Value 0 -Force
        $frequencyRestored = $true
    } catch {
        Write-MedProLog "Could not lift the restore point frequency limit: $($_.Exception.Message)" -Level Warning
    }

    try {
        $stamp = Get-Date -Format "yyyy-MM-dd HH:mm"
        Checkpoint-Computer -Description "$Description ($stamp)" -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
        Write-MedProLog "Restore point created." -Level Success
        $created = $true

    } catch {
        Write-MedProLog "Could not create a restore point: $($_.Exception.Message)" -Level Error
        Write-MedProLog "System Protection may be disabled by policy on this machine." -Level Warning
        $created = $false

    } finally {
        # Put the frequency limit back so this tool does not permanently change
        # how the machine behaves outside of a MedPro Utility run.
        if ($frequencyRestored) {
            Remove-ItemProperty -LiteralPath $frequencyKey -Name "SystemRestorePointCreationFrequency" -Force -ErrorAction SilentlyContinue
        }
    }

    return $created
}
