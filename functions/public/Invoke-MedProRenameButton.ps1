function Invoke-MedProRenameButton {
    <#
    .SYNOPSIS
        Renames this machine to the value typed on the Provisioning tab.

    .DESCRIPTION
        Bound to MedProRenameButton. Runs on the UI thread: a rename is a single
        fast call, so pushing it to a runspace would add complexity without
        making the window any more responsive.
    #>
    [CmdletBinding()]
    param()

    $newName = $sync.MedProComputerNameBox.Text

    $result = Rename-MedProComputer -NewName $newName

    if (-not $result.Success) {
        [System.Windows.MessageBox]::Show(
            $result.Message, "MedPro Utility",
            [System.Windows.MessageBoxButton]::OK,
            [System.Windows.MessageBoxImage]::Warning) | Out-Null
        return
    }

    Set-MedProUIState -Enabled $true -Status $result.Message

    if ($result.RebootRequired) {
        $sync.RebootPending = $true
        $sync.MedProCurrentNameLabel.Text = "$env:COMPUTERNAME  ->  $newName after reboot"
    }
}
