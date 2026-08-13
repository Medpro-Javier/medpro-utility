function Invoke-MedProTweak {
    <#
    .SYNOPSIS
        Applies or reverses a single tweak from config/tweaks.json.

    .DESCRIPTION
        Every tweak is described by up to three parts, all optional:

            registry      values to write, each carrying an OriginalValue
            service       startup types to change, each carrying an OriginalType
            Invoke/Undo   script blocks for anything the other two cannot express

        Apply walks registry -> service -> InvokeScript.
        Undo walks UndoScript -> registry (OriginalValue) -> service (OriginalType),
        script first because a shell extension usually has to be put back before
        the registry values that point at it mean anything.

        A tweak marked "action": true is a one-shot operation such as running
        Disk Cleanup. There is nothing to reverse, so Undo skips it rather than
        pretending it did something.

    .PARAMETER Name
        The config key, e.g. MedProTweaksTelemetry.

    .PARAMETER Tweak
        The parsed config entry.

    .PARAMETER Mode
        Apply or Undo.

    .OUTPUTS
        A result object with Name, Content, Mode, Success, and RestartRequired.

    .EXAMPLE
        Invoke-MedProTweak -Name "MedProTweaksTelemetry" -Tweak $entry -Mode Apply
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Name,
        [Parameter(Mandatory)]$Tweak,
        [ValidateSet("Apply", "Undo")][string]$Mode = "Apply"
    )

    $label = if ($Tweak.Content) { $Tweak.Content } else { $Name }

    if ($Mode -eq "Undo" -and $Tweak.action -eq $true) {
        Write-MedProLog "$label is a one-time action and cannot be undone - skipped." -Level Warning
        return [PSCustomObject]@{
            Name = $Name; Content = $label; Mode = $Mode
            Success = $true; Skipped = $true; RestartRequired = $false
        }
    }

    Write-MedProLog "$($Mode): $label"
    $success = $true

    # --- Undo runs its script first, before the registry it depends on moves ---
    if ($Mode -eq "Undo" -and $Tweak.UndoScript) {
        if (-not (Invoke-MedProScript -Script $Tweak.UndoScript -Label $label)) { $success = $false }
    }

    # --- Registry ---
    foreach ($entry in @($Tweak.registry)) {
        if ($null -eq $entry) { continue }

        $value = if ($Mode -eq "Apply") { $entry.Value } else { $entry.OriginalValue }

        # An undo entry with no OriginalValue is a config bug, not a runtime one.
        # Say so loudly rather than leaving the machine silently modified.
        if ($null -eq $value) {
            Write-MedProLog "  '$label' has no OriginalValue for $($entry.Path)\$($entry.Name) - cannot reverse it." -Level Error
            $success = $false
            continue
        }

        $type = if ($entry.Type) { $entry.Type } else { "DWord" }
        if (-not (Set-MedProRegistry -Path $entry.Path -Name $entry.Name -Type $type -Value $value)) {
            $success = $false
        }
    }

    # --- Services ---
    foreach ($entry in @($Tweak.service)) {
        if ($null -eq $entry) { continue }

        $startupType = if ($Mode -eq "Apply") { $entry.StartupType } else { $entry.OriginalType }
        if ($null -eq $startupType) {
            Write-MedProLog "  '$label' has no OriginalType for service $($entry.Name) - cannot reverse it." -Level Error
            $success = $false
            continue
        }

        if (-not (Set-MedProService -Name $entry.Name -StartupType $startupType)) { $success = $false }
    }

    # --- Apply runs its script last, once the registry is in its new state ---
    if ($Mode -eq "Apply" -and $Tweak.InvokeScript) {
        if (-not (Invoke-MedProScript -Script $Tweak.InvokeScript -Label $label)) { $success = $false }
    }

    if ($success) {
        Write-MedProLog "$label - done" -Level Success
    } else {
        Write-MedProLog "$label - finished with warnings" -Level Warning
    }

    return [PSCustomObject]@{
        Name            = $Name
        Content         = $label
        Mode            = $Mode
        Success         = $success
        Skipped         = $false
        RestartRequired = [bool]$Tweak.restartRequired
        RestartExplorer = [bool]$Tweak.restartExplorer
    }
}
