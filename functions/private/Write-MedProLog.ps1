function Write-MedProLog {
    <#
    .SYNOPSIS
        Writes a timestamped line to the on-screen log, the console, and the transcript.

    .DESCRIPTION
        This is the only logging path in MedPro Utility. Everything the tool does
        to a machine goes through here, so the transcript in
        %ProgramData%\MedProUtility\logs is a complete account of the session.

        Safe to call from a background runspace: UI updates are marshalled back
        to the window's dispatcher thread.

    .PARAMETER Message
        The line to record.

    .PARAMETER Level
        Info, Success, Warning, or Error. Controls console colour and the prefix
        shown in the on-screen log.

    .EXAMPLE
        Write-MedProLog "Disabling telemetry" -Level Info
        Write-MedProLog "Chrome installed" -Level Success
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [AllowEmptyString()]
        [string]$Message,

        [ValidateSet("Info", "Success", "Warning", "Error")]
        [string]$Level = "Info"
    )

    $prefix = switch ($Level) {
        "Success" { "  OK  " }
        "Warning" { " WARN " }
        "Error"   { " FAIL " }
        default   { "      " }
    }

    $colour = switch ($Level) {
        "Success" { "Green" }
        "Warning" { "Yellow" }
        "Error"   { "Red" }
        default   { "Gray" }
    }

    $line = "[{0}]{1} {2}" -f (Get-Date -Format "HH:mm:ss"), $prefix, $Message

    # Console write is what the transcript captures.
    Write-Host $line -ForegroundColor $colour

    if ($null -eq $sync.Form -or $null -eq $sync.MedProLogOutput) { return }

    $uiUpdate = {
        $sync.MedProLogOutput.AppendText($line + [Environment]::NewLine)
        $sync.MedProLogOutput.ScrollToEnd()

        # The full log is collapsed by default, so the newest line is mirrored
        # into the always-visible strip above it. Nothing is ever the only copy:
        # the pane, the console, and the transcript all still have it.
        if ($sync.MedProLastLogLine) { $sync.MedProLastLogLine.Text = $line }
    }.GetNewClosure()

    try {
        $sync.Form.Dispatcher.Invoke([action]$uiUpdate, [System.Windows.Threading.DispatcherPriority]::Normal)
    } catch {
        # The window is closing or already gone. The console and transcript
        # already have the line, so there is nothing worth reporting here.
    }
}
