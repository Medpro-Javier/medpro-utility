function Invoke-MedProRunspace {
    <#
    .SYNOPSIS
        Runs a block of work on a background thread so the window stays responsive.

    .DESCRIPTION
        Installing software and applying tweaks take minutes. Running them on the
        UI thread makes Windows paint the window white and offer to kill it, which
        is exactly the wrong prompt to show a technician mid-provision.

        This creates a runspace seeded with every MedPro function and the shared
        $sync hashtable, then runs the supplied work there. The UI is locked for
        the duration and unlocked in a finally block, so a crash inside the work
        cannot leave the interface permanently disabled.

        Only one task runs at a time. A second call while one is in flight is
        refused rather than queued.

    .PARAMETER ScriptBlock
        The work to run. It executes in a separate runspace, so it can only see
        $sync and the MedPro functions - not variables from the caller's scope.

    .PARAMETER ActivityName
        Shown in the status strip and used in the failure message.

    .EXAMPLE
        Invoke-MedProRunspace -ActivityName "Applying tweaks" -ScriptBlock {
            foreach ($tweak in $sync.SelectedTweaks) { Invoke-MedProTweak $tweak }
        }
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [scriptblock]$ScriptBlock,

        [string]$ActivityName = "Working"
    )

    if ($sync.ProcessRunning) {
        Write-MedProLog "'$ActivityName' was not started - another task is still running." -Level Warning
        return
    }

    $sync.ProcessRunning = $true
    Set-MedProUIState -Enabled $false -Status "$ActivityName..."

    # A fresh runspace starts empty, so every MedPro function has to be handed
    # over explicitly or the work block will fail on its first helper call.
    $sessionState = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
    foreach ($function in Get-ChildItem -Path Function:\ | Where-Object { $_.Name -like "*MedPro*" }) {
        $sessionState.Commands.Add(
            (New-Object System.Management.Automation.Runspaces.SessionStateFunctionEntry(
                $function.Name, $function.Definition))
        )
    }

    $runspace = [runspacefactory]::CreateRunspace($sessionState)
    $runspace.ApartmentState = "STA"
    $runspace.ThreadOptions  = "ReuseThread"
    $runspace.Open()
    $runspace.SessionStateProxy.SetVariable("sync", $sync)

    # Built as text rather than passed as an object: scriptblocks carry an
    # affinity to the runspace that created them, and reusing one across a
    # boundary silently marshals the work back onto the UI thread.
    $body = @"
`$ErrorActionPreference = 'Stop'
try {
$($ScriptBlock.ToString())
}
catch {
    Write-MedProLog "$ActivityName failed: `$(`$_.Exception.Message)" -Level Error
}
finally {
    `$sync.ProcessRunning = `$false
    Set-MedProUIState -Enabled `$true -Status "Ready"
}
"@

    $powershell = [powershell]::Create()
    $powershell.Runspace = $runspace
    $powershell.AddScript($body) | Out-Null

    $handle = $powershell.BeginInvoke()

    # Held so the closing handler can tear these down if the window is closed
    # while work is still in flight.
    $sync.Runspace   = $runspace
    $sync.PowerShell = $powershell

    # Disposal has to wait for the work to finish, and it must not block the UI
    # thread. A dispatcher timer polls the handle a few times a second, which is
    # cheap and keeps every object's lifetime tied to the window.
    $timer = New-Object System.Windows.Threading.DispatcherTimer
    $timer.Interval = [TimeSpan]::FromMilliseconds(500)
    $timer.Add_Tick({
        if (-not $handle.IsCompleted) { return }

        $timer.Stop()
        try { $powershell.EndInvoke($handle) } catch { }
        try { $powershell.Dispose() }         catch { }
        try { $runspace.Close(); $runspace.Dispose() } catch { }

        $sync.Runspace   = $null
        $sync.PowerShell = $null
    }.GetNewClosure())
    $timer.Start()
}
