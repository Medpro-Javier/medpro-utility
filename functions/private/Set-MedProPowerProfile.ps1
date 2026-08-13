function Set-MedProPowerProfile {
    <#
    .SYNOPSIS
        Applies the MedPro standard power plan and screen-lock policy.

    .DESCRIPTION
        Every value comes from config/provisioning.json, so changing MedPro's
        power policy is a config edit rather than a code change.

        The screen lock is the part that matters most here. On a machine that
        handles candidate and client records, an unattended unlocked desktop is
        the exposure - so the screensaver is enabled, made secure, and given a
        timeout, which is the mechanism Windows actually uses to auto-lock a
        session.

        Timeouts are applied to both AC and DC so the same profile is correct on
        a desktop and a laptop.

    .OUTPUTS
        [bool] Whether everything applied cleanly.

    .EXAMPLE
        Set-MedProPowerProfile
    #>
    [CmdletBinding()]
    param()

    $power = $sync.configs.provisioning.power
    if ($null -eq $power) {
        Write-MedProLog "No power section in config/provisioning.json." -Level Error
        return $false
    }

    $success = $true

    # --- Active plan ---------------------------------------------------------
    try {
        & powercfg.exe /setactive $power.planGuid 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) { throw "powercfg /setactive returned $LASTEXITCODE" }
        Write-MedProLog "  power plan set to $($power.planName)"
    } catch {
        Write-MedProLog "  could not set the power plan - $($_.Exception.Message)" -Level Warning
        $success = $false
    }

    # --- Timeouts ------------------------------------------------------------
    $timeouts = @(
        @{ Switch = "monitor-timeout-ac";   Value = $power.monitorTimeoutAC;   Label = "display off (mains)" },
        @{ Switch = "monitor-timeout-dc";   Value = $power.monitorTimeoutDC;   Label = "display off (battery)" },
        @{ Switch = "standby-timeout-ac";   Value = $power.standbyTimeoutAC;   Label = "sleep (mains)" },
        @{ Switch = "standby-timeout-dc";   Value = $power.standbyTimeoutDC;   Label = "sleep (battery)" },
        @{ Switch = "hibernate-timeout-ac"; Value = $power.hibernateTimeoutAC; Label = "hibernate (mains)" },
        @{ Switch = "hibernate-timeout-dc"; Value = $power.hibernateTimeoutDC; Label = "hibernate (battery)" }
    )

    foreach ($timeout in $timeouts) {
        if ($null -eq $timeout.Value) { continue }
        try {
            & powercfg.exe /change $timeout.Switch $timeout.Value 2>&1 | Out-Null
            if ($LASTEXITCODE -ne 0) { throw "powercfg returned $LASTEXITCODE" }
            $shown = if ($timeout.Value -eq 0) { "never" } else { "$($timeout.Value) min" }
            Write-MedProLog "  $($timeout.Label): $shown"
        } catch {
            Write-MedProLog "  could not set $($timeout.Label) - $($_.Exception.Message)" -Level Warning
            $success = $false
        }
    }

    # --- Lid behaviour -------------------------------------------------------
    # 0 = do nothing, 1 = sleep, 2 = hibernate, 3 = shut down. Skipped silently
    # on a desktop, where the setting exists but means nothing.
    $lidGuid = "5ca83367-6e45-459f-a27b-476b1d01c936"
    $subGuid = "4f971e89-eebd-4455-a8de-9e59040e7347"
    foreach ($lid in @(
        @{ Scope = "setacvalueindex"; Value = $power.lidActionAC; Label = "lid closed (mains)" },
        @{ Scope = "setdcvalueindex"; Value = $power.lidActionDC; Label = "lid closed (battery)" }
    )) {
        if ($null -eq $lid.Value) { continue }
        try {
            & powercfg.exe "/$($lid.Scope)" SCHEME_CURRENT $subGuid $lidGuid $lid.Value 2>&1 | Out-Null
            if ($LASTEXITCODE -eq 0) { Write-MedProLog "  $($lid.Label) set" }
        } catch {
            # Desktops have no lid. Not worth a warning.
        }
    }

    & powercfg.exe /setactive SCHEME_CURRENT 2>&1 | Out-Null

    # --- Screen lock ---------------------------------------------------------
    if ($power.screenLockMinutes) {
        $seconds = [int]$power.screenLockMinutes * 60
        $desktop = "HKCU:\Control Panel\Desktop"

        $locked = $true
        $locked = (Set-MedProRegistry -Path $desktop -Name "ScreenSaveActive"   -Type String -Value "1")       -and $locked
        $locked = (Set-MedProRegistry -Path $desktop -Name "ScreenSaverIsSecure" -Type String -Value "1")       -and $locked
        $locked = (Set-MedProRegistry -Path $desktop -Name "ScreenSaveTimeOut"   -Type String -Value "$seconds") -and $locked

        # A screensaver has to be set for the timeout to fire at all.
        $locked = (Set-MedProRegistry -Path $desktop -Name "SCRNSAVE.EXE" -Type String -Value "scrnsave.scr") -and $locked

        if ($locked) {
            Write-MedProLog "  screen locks after $($power.screenLockMinutes) minutes and requires a password"
        } else {
            $success = $false
        }
    }

    return $success
}
