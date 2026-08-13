function Add-MedProCheckBoxCards {
    <#
    .SYNOPSIS
        Renders config entries into MedPro cards of checkboxes, grouped by category.

    .DESCRIPTION
        Shared by the Tweaks, Debloat, and Install tabs. Each of those is the same
        shape - a list of named, described, categorised things a technician ticks -
        so they share one renderer rather than three that drift apart.

        Categories appear in the order they first occur in the config, which makes
        the JSON file itself the source of truth for reading order.

        Every checkbox carries its config key in .Tag and is registered in the
        supplied control set, which is what Get-MedProSelection reads back.

    .PARAMETER Panel
        The StackPanel to fill. Cleared first.

    .PARAMETER Entries
        Output of Get-MedProConfigEntries: objects with .Name and .Value.

    .PARAMETER ControlSet
        Hashtable to populate with name-to-checkbox mappings.

    .PARAMETER MaxColumns
        Ceiling on how many checkbox columns a card may use. The actual count is
        whatever fits the window: the checkboxes live in a WrapPanel whose cell
        width is measured from the longest label in the config, so a wide window
        packs more columns and a narrow one reflows instead of clipping. That is
        what keeps a tab on one screen without a scrollbar.

    .OUTPUTS
        [int] Number of categories rendered.

    .EXAMPLE
        Add-MedProCheckBoxCards -Panel $sync.MedProTweaksPanel -Entries $entries -ControlSet $sync.TweakCheckBoxes
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]$Panel,

        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        $Entries,

        [Parameter(Mandatory)]
        [hashtable]$ControlSet,

        [int]$MaxColumns = 5
    )

    $Panel.Children.Clear()
    $ControlSet.Clear()

    if (@($Entries).Count -eq 0) { return 0 }

    $categories = New-Object System.Collections.Generic.List[string]
    foreach ($entry in $Entries) {
        $category = if ($entry.Value.category) { $entry.Value.category } else { "Other" }
        if (-not $categories.Contains($category)) { $categories.Add($category) }
    }

    $cautionBrush = $sync.Form.FindResource("Caution")

    # Every checkbox is built up front so the column width can be measured from
    # the real controls before any of them is placed. One width is used across
    # the whole tab, which keeps the cards on a single column grid rather than
    # letting each category drift to its own.
    foreach ($entry in $Entries) {
        $checkBox = New-Object System.Windows.Controls.CheckBox
        $checkBox.Content = if ($entry.Value.Content) { $entry.Value.Content } else { $entry.Value.content }
        $checkBox.Style   = $sync.Form.FindResource("MedProCheckBox")
        $checkBox.Tag     = $entry.Name

        if ($entry.Value.Description)     { $checkBox.ToolTip = $entry.Value.Description }
        elseif ($entry.Value.description) { $checkBox.ToolTip = $entry.Value.description }

        # Caution items are coloured rather than hidden: a technician should
        # see at a glance which choices carry weight.
        if ($entry.Value.caution -eq $true) { $checkBox.Foreground = $cautionBrush }

        $ControlSet[$entry.Name] = $checkBox
    }

    # The gutter is what stops two full-width labels sitting flush against each
    # other; the measurement itself already covers the tick box and its margin.
    $itemWidth = (Get-MedProLabelWidth -Controls $ControlSet.Values) + 18

    foreach ($category in $categories) {
        $inCategory = @($Entries | Where-Object {
            $c = if ($_.Value.category) { $_.Value.category } else { "Other" }
            $c -eq $category
        })

        $card  = New-Object System.Windows.Controls.Border
        $card.Style = $sync.Form.FindResource("Card")

        $stack = New-Object System.Windows.Controls.StackPanel
        $card.Child = $stack

        $heading = New-Object System.Windows.Controls.TextBlock
        $heading.Text  = $category
        $heading.Style = $sync.Form.FindResource("Heading")
        [void]$stack.Children.Add($heading)

        # A category note, taken from whichever entry in the group defines one.
        $note = ($inCategory | Where-Object { $_.Value.categoryNote } | Select-Object -First 1).Value.categoryNote
        if ($note) {
            $noteBlock = New-Object System.Windows.Controls.TextBlock
            $noteBlock.Text   = $note
            $noteBlock.Style  = $sync.Form.FindResource("Body")
            $noteBlock.Margin = New-Object System.Windows.Thickness(0, 6, 0, 0)
            [void]$stack.Children.Add($noteBlock)
        }

        # WrapPanel rather than UniformGrid: the column count follows the window
        # width instead of being fixed, so maximising actually buys density.
        $grid = New-Object System.Windows.Controls.WrapPanel
        $grid.Orientation = [System.Windows.Controls.Orientation]::Horizontal
        $grid.ItemWidth   = $itemWidth
        $grid.ItemHeight  = 25
        $grid.MaxWidth    = $itemWidth * $MaxColumns
        $grid.HorizontalAlignment = [System.Windows.HorizontalAlignment]::Left
        $grid.Margin      = New-Object System.Windows.Thickness(0, 8, 0, 0)
        [void]$stack.Children.Add($grid)

        foreach ($entry in $inCategory) {
            [void]$grid.Children.Add($ControlSet[$entry.Name])
        }

        [void]$Panel.Children.Add($card)
    }

    return $categories.Count
}
