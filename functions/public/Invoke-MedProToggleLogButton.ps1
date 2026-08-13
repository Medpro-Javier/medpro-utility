function Invoke-MedProToggleLogButton {
    <#
    .SYNOPSIS
        Opens and closes the full activity log pane.

    .DESCRIPTION
        The log pane is collapsed at startup so that each tab fits the window
        without scrolling; the strip above it still shows the most recent line,
        so nothing is invisible, only compact.

        Set-MedProUIState opens the pane on its own when a task starts, which is
        the case where a technician actually needs the running detail.

    .EXAMPLE
        Invoke-MedProToggleLogButton
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.MedProLogPanel) { return }

    $isOpen = $sync.MedProLogPanel.Visibility -eq [System.Windows.Visibility]::Visible

    $sync.MedProLogPanel.Visibility = if ($isOpen) {
        [System.Windows.Visibility]::Collapsed
    } else {
        [System.Windows.Visibility]::Visible
    }

    if ($sync.MedProToggleLogButton) {
        $sync.MedProToggleLogButton.Content = if ($isOpen) { "Show full log" } else { "Hide full log" }
    }

    # Reopening on a long session should land at the newest line, not wherever
    # the technician left the scroll position before collapsing it.
    if (-not $isOpen -and $sync.MedProLogOutput) { $sync.MedProLogOutput.ScrollToEnd() }
}
