function Invoke-MedProApplyTweaksButton {
    <#
    .SYNOPSIS
        Applies every ticked tweak, after taking a restore point.

    .DESCRIPTION
        Bound to MedProApplyTweaksButton. Confirms the selection, then hands the
        batch to a background runspace so the window stays responsive.

        The restore point comes first and its failure is surfaced as a decision
        rather than a log line: applying a batch of registry and service changes
        with no way back is a choice a technician should make deliberately.
    #>
    [CmdletBinding()]
    param()

    $selected = Get-MedProSelection -ControlSet $sync.TweakCheckBoxes

    if ($selected.Count -eq 0) {
        Write-MedProLog "Nothing selected - tick the tweaks you want to apply." -Level Warning
        return
    }

    $cautionCount = @($selected | Where-Object { $sync.configs.tweaks.$_.caution -eq $true }).Count

    $message = "Apply $($selected.Count) tweak$(if ($selected.Count -ne 1) { 's' }) to this machine?"
    if ($cautionCount -gt 0) {
        $message += "`n`n$cautionCount of them are marked caution and change how Windows behaves in ways users will notice."
    }
    $message += "`n`nA system restore point will be created first."

    $answer = [System.Windows.MessageBox]::Show(
        $message, "MedPro Utility",
        [System.Windows.MessageBoxButton]::OKCancel,
        [System.Windows.MessageBoxImage]::Question)

    if ($answer -ne [System.Windows.MessageBoxResult]::OK) {
        Write-MedProLog "Cancelled - nothing was changed."
        return
    }

    # The runspace runs in its own scope and cannot see local variables, so the
    # work list travels across on $sync.
    $sync.PendingTweaks = $selected

    Invoke-MedProRunspace -ActivityName "Applying tweaks" -ScriptBlock {

        Write-MedProLog "----- Applying $($sync.PendingTweaks.Count) tweaks -----"

        if (-not (New-MedProRestorePoint -Description "MedPro Utility - before tweaks")) {
            Write-MedProLog "No restore point was created. Continuing, but there is no automatic way back." -Level Warning
        }

        $results = foreach ($name in $sync.PendingTweaks) {
            $tweak = $sync.configs.tweaks.$name
            if ($null -eq $tweak) {
                Write-MedProLog "'$name' is selected but missing from the config - skipped." -Level Error
                continue
            }
            Invoke-MedProTweak -Name $name -Tweak $tweak -Mode Apply
        }

        $results = @($results)
        $failed  = @($results | Where-Object { -not $_.Success })

        Write-MedProLog "----- $($results.Count - $failed.Count) of $($results.Count) applied cleanly -----" -Level $(if ($failed.Count) { "Warning" } else { "Success" })

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
