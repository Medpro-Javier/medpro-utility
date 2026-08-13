function Get-MedProSelection {
    <#
    .SYNOPSIS
        Returns the config keys of every ticked checkbox in a control set.

    .DESCRIPTION
        The bridge between the interface and the engines. Both the Tweaks tab and
        the Install tab keep their generated checkboxes in a name-to-control
        hashtable on $sync; this reads the ticked ones back out as plain strings.

        Reading IsChecked touches WPF objects, so the read is marshalled onto the
        dispatcher thread. That makes this safe to call from inside a runspace.

    .PARAMETER ControlSet
        The hashtable of checkboxes, e.g. $sync.TweakCheckBoxes.

    .OUTPUTS
        [string[]] Config keys, in the order the controls were created.

    .EXAMPLE
        $selected = Get-MedProSelection -ControlSet $sync.TweakCheckBoxes
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [AllowNull()]
        $ControlSet
    )

    if ($null -eq $ControlSet -or $ControlSet.Count -eq 0) { return @() }

    $selected = New-Object System.Collections.Generic.List[string]

    $read = {
        foreach ($key in $ControlSet.Keys) {
            if ($ControlSet[$key].IsChecked -eq $true) { $selected.Add($key) }
        }
    }.GetNewClosure()

    if ($sync.Form) {
        $sync.Form.Dispatcher.Invoke([action]$read, [System.Windows.Threading.DispatcherPriority]::Normal)
    } else {
        & $read
    }

    return @($selected)
}
