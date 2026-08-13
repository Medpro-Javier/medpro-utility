function Set-MedProUIState {
    <#
    .SYNOPSIS
        Enables or disables the interface while a long-running task is in flight.

    .DESCRIPTION
        Locks the tab area so a technician cannot start a second batch of tweaks
        on top of a running one, and updates the status strip so the window never
        looks frozen.

        Safe to call from a background runspace.

    .PARAMETER Enabled
        $false while work is running, $true when it finishes.

    .PARAMETER Status
        Text for the status strip. Omit to leave the current text alone.

    .EXAMPLE
        Set-MedProUIState -Enabled $false -Status "Applying tweaks..."
        Set-MedProUIState -Enabled $true  -Status "Ready"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [bool]$Enabled,

        [string]$Status
    )

    if ($null -eq $sync.Form) { return }

    $uiUpdate = {
        if ($sync.MedProTabControl) { $sync.MedProTabControl.IsEnabled = $Enabled }
        if ($sync.MedProBusyBar)    { $sync.MedProBusyBar.IsIndeterminate = (-not $Enabled) }

        if ($sync.MedProStatusLabel -and -not [string]::IsNullOrWhiteSpace($Status)) {
            $sync.MedProStatusLabel.Text = $Status
        }

        # The log pane is collapsed by default to keep a tab on one screen, but
        # a run in flight is exactly when a technician wants to watch it, so it
        # opens itself here. It is left open afterwards - closing it under
        # someone mid-read would be worse than the space it costs.
        if (-not $Enabled -and $sync.MedProLogPanel -and
            $sync.MedProLogPanel.Visibility -ne [System.Windows.Visibility]::Visible) {
            $sync.MedProLogPanel.Visibility = [System.Windows.Visibility]::Visible
            if ($sync.MedProToggleLogButton) { $sync.MedProToggleLogButton.Content = "Hide full log" }
        }
    }.GetNewClosure()

    try {
        $sync.Form.Dispatcher.Invoke([action]$uiUpdate, [System.Windows.Threading.DispatcherPriority]::Normal)
    } catch {
        # Window gone. Nothing to update.
    }
}
