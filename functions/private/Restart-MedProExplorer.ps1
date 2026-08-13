function Restart-MedProExplorer {
    <#
    .SYNOPSIS
        Restarts Windows Explorer so shell tweaks take effect immediately.

    .DESCRIPTION
        Taskbar alignment, hidden files, file extensions, and the classic context
        menu all live in HKCU and are only read by explorer.exe at startup.
        Without this, a technician applies a tweak, sees nothing change, and
        applies it again.

        Explorer normally relaunches itself when killed. The wait-and-start below
        covers the case where it does not, which would otherwise leave the
        machine with no taskbar and no desktop.

    .EXAMPLE
        Restart-MedProExplorer
    #>
    [CmdletBinding()]
    param()

    Write-MedProLog "Restarting Windows Explorer so shell changes take effect..."

    try {
        Get-Process -Name explorer -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue

        # Windows usually respawns the shell on its own; give it a moment before
        # deciding it will not.
        Start-Sleep -Seconds 2

        if (-not (Get-Process -Name explorer -ErrorAction SilentlyContinue)) {
            Start-Process explorer.exe
            Start-Sleep -Seconds 1
        }

        Write-MedProLog "Explorer restarted." -Level Success

    } catch {
        Write-MedProLog "Explorer did not restart cleanly: $($_.Exception.Message)" -Level Warning
        Write-MedProLog "Sign out and back in if the taskbar looks wrong." -Level Warning
    }
}
