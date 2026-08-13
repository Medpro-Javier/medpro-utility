function Add-MedProProvisioningControls {
    <#
    .SYNOPSIS
        Fills in the Provisioning tab's live state and config-driven text.

    .DESCRIPTION
        Unlike the other tabs, the Provisioning layout is authored in the XAML -
        it needs a text box and distinct actions rather than a list of checkboxes.
        What this does is populate it with the current machine state and whatever
        MedPro has configured, so a technician can see what they are changing
        from before they change it.

        Where a config section is not filled in, the tab says so plainly instead
        of showing a button that will fail when pressed.

    .EXAMPLE
        Add-MedProProvisioningControls
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.MedProCurrentNameLabel) { return }

    $provisioning = $sync.configs.provisioning

    # --- Naming --------------------------------------------------------------
    # The box is pre-filled with the current name rather than a generated one:
    # the technician edits what is there, or leaves it alone.
    $sync.MedProCurrentNameLabel.Text = $env:COMPUTERNAME
    $sync.MedProComputerNameBox.Text  = $env:COMPUTERNAME

    $sync.MedProNamingHint.Text = "Edit the name below to rename this machine, or leave it as it is. " +
                                  "Up to 15 characters, letters, numbers, and hyphens. The change takes effect after a reboot."

    # --- Join state ----------------------------------------------------------
    # Read from the machine rather than assumed, so the tab is accurate on a
    # PC that was already partly provisioned by someone else.
    try {
        $computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction Stop
        $entraJoined = $false
        try {
            $entraJoined = ((& dsregcmd.exe /status 2>&1 | Out-String) -match 'AzureAdJoined\s*:\s*YES')
        } catch { }

        $sync.MedProJoinStateLabel.Text =
            if ($computerSystem.PartOfDomain -and $entraJoined) { "Hybrid joined - $($computerSystem.Domain) + Entra ID" }
            elseif ($computerSystem.PartOfDomain)               { "Domain joined - $($computerSystem.Domain)" }
            elseif ($entraJoined)                               { "Entra ID joined" }
            else                                               { "Workgroup - $($computerSystem.Workgroup)" }

    } catch {
        $sync.MedProJoinStateLabel.Text = "Could not be determined"
    }

    # --- Domain --------------------------------------------------------------
    $domain = $provisioning.domain
    if ($domain.configured -eq $true -and $domain.name) {
        $sync.MedProDomainHint.Text = "Joins this machine to $($domain.name)" +
            $(if ($domain.ouPath) { ", placing the computer object in $($domain.ouPath)." } else { "." })
    } else {
        $sync.MedProDomainHint.Text = "No domain is configured. Set 'name', 'ouPath', and 'configured': true in the domain " +
                                      "section of config/provisioning.json, then rebuild."
    }

    # --- Power ---------------------------------------------------------------
    if ($provisioning.power.description) {
        $sync.MedProPowerHint.Text = $provisioning.power.description
    }
}
