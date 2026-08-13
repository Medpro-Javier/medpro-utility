function Invoke-MedProUndoTweaksButton {
    <#
    .SYNOPSIS
        Reverses every ticked tweak, restoring the original values.

    .DESCRIPTION
        Bound to MedProUndoTweaksButton. Each tweak is put back using the
        OriginalValue and OriginalType recorded in the config.

        Undo restores what the config says stock Windows 11 looks like, which is
        not necessarily what this particular machine looked like before the tool
        ran. On a machine carrying pre-existing Group Policy or an OEM
        customization, System Restore is the more faithful way back - so the
        confirmation says so rather than overstating what this button does.
    #>
    [CmdletBinding()]
    param()

    $selected = Get-MedProSelection -ControlSet $sync.TweakCheckBoxes

    if ($selected.Count -eq 0) {
        Write-MedProLog "Nothing selected - tick the tweaks you want to reverse." -Level Warning
        return
    }

    # One-shot actions have no reverse. Saying so up front beats a run that
    # reports "skipped" for half the selection.
    $reversible = @($selected | Where-Object { $sync.configs.tweaks.$_.action -ne $true })
    $oneShot    = $selected.Count - $reversible.Count

    if ($reversible.Count -eq 0) {
        Write-MedProLog "Everything selected is a one-time action - there is nothing to reverse." -Level Warning
        return
    }

    $message = "Reverse $($reversible.Count) tweak$(if ($reversible.Count -ne 1) { 's' })?"
    if ($oneShot -gt 0) {
        $message += "`n`n$oneShot selected item$(if ($oneShot -ne 1) { 's are' } else { ' is' }) a one-time action and will be skipped."
    }
    $message += "`n`nThis restores stock Windows 11 values. If this machine had its own settings before the tool ran, use System Restore instead."

    $answer = [System.Windows.MessageBox]::Show(
        $message, "MedPro Utility",
        [System.Windows.MessageBoxButton]::OKCancel,
        [System.Windows.MessageBoxImage]::Question)

    if ($answer -ne [System.Windows.MessageBoxResult]::OK) {
        Write-MedProLog "Cancelled - nothing was changed."
        return
    }

    $sync.PendingTweaks = $reversible

    Invoke-MedProRunspace -ActivityName "Reversing tweaks" -ScriptBlock {

        Write-MedProLog "----- Reversing $($sync.PendingTweaks.Count) tweaks -----"

        $results = foreach ($name in $sync.PendingTweaks) {
            $tweak = $sync.configs.tweaks.$name
            if ($null -eq $tweak) {
                Write-MedProLog "'$name' is selected but missing from the config - skipped." -Level Error
                continue
            }
            Invoke-MedProTweak -Name $name -Tweak $tweak -Mode Undo
        }

        $results = @($results)
        $failed  = @($results | Where-Object { -not $_.Success })

        Write-MedProLog "----- $($results.Count - $failed.Count) of $($results.Count) reversed cleanly -----" -Level $(if ($failed.Count) { "Warning" } else { "Success" })

        foreach ($failure in $failed) {
            Write-MedProLog "Review: $($failure.Content)" -Level Warning
        }

        if (@($results | Where-Object { $_.RestartExplorer }).Count -gt 0) {
            Restart-MedProExplorer
        }

        if (@($results | Where-Object { $_.RestartRequired }).Count -gt 0) {
            Write-MedProLog "A reboot is required before some of these changes take effect." -Level Warning
        }
    }
}
