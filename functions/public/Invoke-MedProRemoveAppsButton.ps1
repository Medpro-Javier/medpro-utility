function Invoke-MedProRemoveAppsButton {
    <#
    .SYNOPSIS
        Removes the selected groups of Windows bloatware.

    .DESCRIPTION
        Bound to MedProRemoveAppsButton.

        This is the one destructive operation in the tool. Unlike a tweak, there
        is no OriginalValue to put back - reinstalling a removed Store app means
        going to the Store. The confirmation says that plainly rather than
        implying a symmetry with the Tweaks tab that does not exist.

        The keep-list guard lives in Remove-MedProAppx, so it protects this path
        and any future caller equally.
    #>
    [CmdletBinding()]
    param()

    $selected = Get-MedProSelection -ControlSet $sync.DebloatCheckBoxes

    if ($selected.Count -eq 0) {
        Write-MedProLog "Nothing selected - tick the app groups you want removed." -Level Warning
        return
    }

    $groupNames = @($selected | ForEach-Object { $sync.configs.debloat.groups.$_.content })

    $message  = "Remove these app groups from this machine?`n`n"
    $message += ($groupNames | ForEach-Object { "  - $_" }) -join "`n"
    $message += "`n`nThis cannot be undone from this tool. Reinstalling a removed app means going to the Microsoft Store."

    $answer = [System.Windows.MessageBox]::Show(
        $message, "MedPro Utility",
        [System.Windows.MessageBoxButton]::OKCancel,
        [System.Windows.MessageBoxImage]::Warning)

    if ($answer -ne [System.Windows.MessageBoxResult]::OK) {
        Write-MedProLog "Cancelled - no apps were removed."
        return
    }

    $sync.PendingDebloat = $selected

    Invoke-MedProRunspace -ActivityName "Removing apps" -ScriptBlock {

        $keepList = @($sync.configs.debloat.keepList)
        Write-MedProLog "----- Removing $($sync.PendingDebloat.Count) app groups -----"

        $totalRemoved = 0
        $totalBlocked = 0
        $totalFailed  = 0

        foreach ($name in $sync.PendingDebloat) {
            $group = $sync.configs.debloat.groups.$name
            if ($null -eq $group) {
                Write-MedProLog "'$name' is selected but missing from the config - skipped." -Level Error
                continue
            }

            Write-MedProLog "$($group.content)"
            $result = Remove-MedProAppx -Pattern @($group.packages) -KeepList $keepList

            $totalRemoved += $result.Removed
            $totalBlocked += $result.Blocked
            $totalFailed  += $result.Failed

            if ($result.Removed -eq 0 -and $result.Failed -eq 0) {
                Write-MedProLog "  nothing to remove - none of these are installed."
            }
        }

        Write-MedProLog "----- $totalRemoved packages removed -----" -Level $(if ($totalFailed) { "Warning" } else { "Success" })

        if ($totalBlocked -gt 0) {
            Write-MedProLog "$totalBlocked package(s) were protected by the keep-list and left in place." -Level Warning
        }
        if ($totalFailed -gt 0) {
            Write-MedProLog "$totalFailed removal(s) failed. Some packages are locked by Windows and can only be removed offline." -Level Warning
        }

        Write-MedProLog "Apply the matching policy tweaks on the Tweaks tab so Windows does not reinstall these on the next feature update." -Level Warning
    }
}
