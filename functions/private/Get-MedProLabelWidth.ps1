function Get-MedProLabelWidth {
    <#
    .SYNOPSIS
        Measures the widest of a set of already-built controls, in device-independent pixels.

    .DESCRIPTION
        The checkbox tabs size their columns from their content rather than from
        a hard-coded number, so that adding a longer entry to config/*.json
        widens the column instead of quietly clipping the text or overlapping
        its neighbour.

        The measurement is taken from the real controls, with their real style
        applied, rather than from a character count or a bare TextBlock. Both of
        those under-read by enough to cause visible overlap, because they miss
        the tick box, its margin, and the font the template actually resolves.

        Measure() does not need the control to be in a visual tree, so this is
        safe to call before the window is shown.

    .PARAMETER Controls
        The controls that have to fit. Measured, not modified.

    .PARAMETER Minimum
        Floor for the result, so a tab of very short labels does not end up with
        comically narrow columns.

    .OUTPUTS
        [double] Width of the widest control.

    .EXAMPLE
        Get-MedProLabelWidth -Controls $checkBoxes
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        $Controls,

        [double]$Minimum = 160
    )

    $widest = $Minimum
    $unbounded = New-Object System.Windows.Size([double]::PositiveInfinity, [double]::PositiveInfinity)

    foreach ($control in $Controls) {
        if ($null -eq $control) { continue }
        try {
            $control.Measure($unbounded)
            if ($control.DesiredSize.Width -gt $widest) { $widest = $control.DesiredSize.Width }
        } catch {
            # A control that will not measure is not worth failing the whole tab
            # over. The remaining ones still set a sensible column width.
        }
    }

    return [Math]::Ceiling($widest)
}
