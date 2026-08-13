function Invoke-MedProOpenLogButton {
    <#
    .SYNOPSIS
        Opens the folder holding this session's transcript in File Explorer.

    .DESCRIPTION
        Bound automatically to the control named MedProOpenLogButton. Every run
        of this tool writes a full transcript; this is the shortest path from
        "what did it just do to this machine" to the answer.
    #>
    [CmdletBinding()]
    param()

    if (-not (Test-Path -LiteralPath $sync.logPath)) {
        Write-MedProLog "Log folder $($sync.logPath) does not exist yet." -Level Warning
        return
    }

    # Selecting the current session's file saves scrolling a folder full of runs.
    if ($sync.logFile -and (Test-Path -LiteralPath $sync.logFile)) {
        Start-Process explorer.exe -ArgumentList "/select,`"$($sync.logFile)`""
    } else {
        Start-Process explorer.exe -ArgumentList "`"$($sync.logPath)`""
    }

    Write-MedProLog "Opened $($sync.logPath)"
}
