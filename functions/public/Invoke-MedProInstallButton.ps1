function Invoke-MedProInstallButton {
    <#
    .SYNOPSIS
        Installs every ticked application from the MedPro catalog.

    .DESCRIPTION
        Bound to MedProInstallButton. Runs the batch in a background runspace and
        reports per-application outcomes honestly at the end.

        The summary distinguishes installs that came from the vendor link from
        those that fell back to winget. A run where everything quietly came from
        winget means the catalog's links have rotted, and that should be visible
        in the log rather than discovered months later.
    #>
    [CmdletBinding()]
    param()

    $selected = Get-MedProSelection -ControlSet $sync.InstallCheckBoxes

    if ($selected.Count -eq 0) {
        Write-MedProLog "Nothing selected - tick the applications you want installed." -Level Warning
        return
    }

    # --- Share access, checked before the runspace starts --------------------
    # Get-Credential raises a dialog, and a dialog raised from a background
    # runspace is one nobody ever sees. So the shares are sorted out here, on
    # the UI thread, while a prompt can still reach the technician.
    $sharePaths = @($selected |
        ForEach-Object { $sync.configs.applications.$_.path } |
        Where-Object { $_ })

    if ($sharePaths.Count -gt 0) {
        $access = Connect-MedProShare -Path $sharePaths

        $unreachable = @($access.Keys | Where-Object { -not $access[$_] })
        if ($unreachable.Count -gt 0) {
            $blocked = @($selected | Where-Object {
                $path = $sync.configs.applications.$_.path
                $path -and ($unreachable | Where-Object { $path -like "$_*" })
            })

            $names = ($blocked | ForEach-Object { "  - $($sync.configs.applications.$_.content)" }) -join "`n"
            $answer = [System.Windows.MessageBox]::Show(
                "These applications are on a share this machine cannot reach:`n`n$names`n`nContinue without them?",
                "MedPro Utility",
                [System.Windows.MessageBoxButton]::OKCancel,
                [System.Windows.MessageBoxImage]::Warning)

            if ($answer -ne [System.Windows.MessageBoxResult]::OK) {
                Write-MedProLog "Cancelled - nothing was installed."
                return
            }

            foreach ($name in $blocked) {
                Write-MedProLog "Skipping $($sync.configs.applications.$name.content) - its share is unreachable." -Level Warning
            }
            $selected = @($selected | Where-Object { $blocked -notcontains $_ })

            if ($selected.Count -eq 0) {
                Write-MedProLog "Nothing left to install." -Level Warning
                return
            }
        }
    }

    # --- Warn about anything that will not install silently -------------------
    # Better to know a "walk away" run needs a human before starting it than to
    # come back twenty minutes later to a dialog waiting for a click.
    $interactive = @($selected | Where-Object { $sync.configs.applications.$_.interactive -eq $true })
    if ($interactive.Count -gt 0) {
        $names = ($interactive | ForEach-Object { "  - $($sync.configs.applications.$_.content)" }) -join "`n"
        Write-MedProLog "$($interactive.Count) of these will not install silently and need a technician at the machine:" -Level Warning
        foreach ($name in $interactive) {
            Write-MedProLog "  $($sync.configs.applications.$name.content)" -Level Warning
        }

        [System.Windows.MessageBox]::Show(
            "These do not install silently and will show their own installer:`n`n$names`n`nStay at the machine to click through them.",
            "MedPro Utility",
            [System.Windows.MessageBoxButton]::OK,
            [System.Windows.MessageBoxImage]::Information) | Out-Null
    }

    $sync.PendingInstalls = $selected

    Invoke-MedProRunspace -ActivityName "Installing applications" -ScriptBlock {

        $total = $sync.PendingInstalls.Count
        Write-MedProLog "----- Installing $total applications -----"

        $results = New-Object System.Collections.Generic.List[object]
        $index = 0

        foreach ($name in $sync.PendingInstalls) {
            $index++

            $app = $sync.configs.applications.$name
            if ($null -eq $app) {
                Write-MedProLog "'$name' is selected but missing from the catalog - skipped." -Level Error
                continue
            }

            Set-MedProUIState -Enabled $false -Status "Installing $index of $total - $($app.content)"
            $results.Add((Install-MedProProgram -Name $name -App $app))
        }

        # --- Summary ---------------------------------------------------------
        $installed = @($results | Where-Object { $_.Status -eq "Installed" })
        $present   = @($results | Where-Object { $_.Status -eq "AlreadyPresent" })
        $failed    = @($results | Where-Object { $_.Status -eq "Failed" })
        $viaWinget = @($installed | Where-Object { $_.Source -eq "winget" })

        Write-MedProLog "----- $($installed.Count) installed, $($present.Count) already present, $($failed.Count) failed -----" `
            -Level $(if ($failed.Count) { "Warning" } else { "Success" })

        foreach ($failure in $failed) {
            Write-MedProLog "Failed: $($failure.Content)" -Level Error
        }

        if ($viaWinget.Count -gt 0) {
            Write-MedProLog "$($viaWinget.Count) application(s) fell back to winget. Check their links in config/applications.json:" -Level Warning
            foreach ($fallback in $viaWinget) {
                Write-MedProLog "  $($fallback.Content)" -Level Warning
            }
        }

        if (@($results | Where-Object { $_.RebootRequired }).Count -gt 0) {
            Write-MedProLog "A reboot is needed to finish one or more installs." -Level Warning
        }
    }
}
