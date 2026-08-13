function Invoke-MedProScript {
    <#
    .SYNOPSIS
        Runs the InvokeScript / UndoScript blocks carried by a config entry.

    .DESCRIPTION
        Some changes cannot be expressed as a registry value - unregistering a
        scheduled task, calling powercfg, removing a shell extension. Those live
        in the config as script text and run through here.

        Each block is isolated: one failing block is logged and the rest still
        run, so a single unsupported operation cannot abandon a half-applied tweak.

    .PARAMETER Script
        One or more strings of PowerShell to execute, taken from the config entry.

    .PARAMETER Label
        Name of the owning tweak, used in log lines.

    .EXAMPLE
        Invoke-MedProScript -Script $tweak.InvokeScript -Label "Telemetry - Disable"
    #>
    [CmdletBinding()]
    param(
        [AllowNull()]
        [string[]]$Script,

        [string]$Label = "script"
    )

    if (-not $Script -or $Script.Count -eq 0) { return $true }

    $allSucceeded = $true

    foreach ($block in $Script) {
        if ([string]::IsNullOrWhiteSpace($block)) { continue }

        try {
            $scriptBlock = [scriptblock]::Create($block)
            & $scriptBlock
        } catch {
            Write-MedProLog "  script step failed in '$Label' - $($_.Exception.Message)" -Level Warning
            $allSucceeded = $false
        }
    }

    return $allSucceeded
}
