function Join-MedProDomain {
    <#
    .SYNOPSIS
        Joins the machine to the MedPro Active Directory domain.

    .DESCRIPTION
        Credentials are supplied by the technician at run time and are never
        written to the repository, the config, or the transcript. The credential
        object exists only for the lifetime of this call.

        The domain and OU come from config/provisioning.json. If that section is
        not configured the function refuses rather than prompting for a domain
        name, because a typo there creates a computer object in the wrong place
        that someone has to find and clean up later.

    .PARAMETER Credential
        An account with rights to join a machine to the domain.

    .OUTPUTS
        Result object with Success, Message, and RebootRequired.

    .EXAMPLE
        Join-MedProDomain -Credential (Get-Credential)
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [System.Management.Automation.PSCredential]$Credential
    )

    $domain = $sync.configs.provisioning.domain

    if ($domain.configured -ne $true -or [string]::IsNullOrWhiteSpace($domain.name)) {
        $message = "The domain section of config/provisioning.json is not configured. Set 'name', 'ouPath', and 'configured': true, then rebuild."
        Write-MedProLog $message -Level Error
        return [PSCustomObject]@{ Success = $false; Message = $message; RebootRequired = $false }
    }

    # Already joined? Re-joining a domain the machine is on is not harmless.
    $computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem
    if ($computerSystem.PartOfDomain -and $computerSystem.Domain -eq $domain.name) {
        $message = "This machine is already joined to $($domain.name)."
        Write-MedProLog $message -Level Success
        return [PSCustomObject]@{ Success = $true; Message = $message; RebootRequired = $false }
    }

    try {
        Write-MedProLog "Joining $($domain.name)..."

        $parameters = @{
            DomainName  = $domain.name
            Credential  = $Credential
            Force       = $true
            ErrorAction = "Stop"
        }
        if (-not [string]::IsNullOrWhiteSpace($domain.ouPath)) {
            $parameters.OUPath = $domain.ouPath
            Write-MedProLog "  target OU: $($domain.ouPath)"
        }

        Add-Computer @parameters

        Write-MedProLog "Joined $($domain.name). Reboot to complete the join." -Level Success
        return [PSCustomObject]@{
            Success = $true
            Message = "Joined $($domain.name). Reboot required."
            RebootRequired = $true
        }

    } catch {
        Write-MedProLog "Domain join failed: $($_.Exception.Message)" -Level Error
        return [PSCustomObject]@{ Success = $false; Message = $_.Exception.Message; RebootRequired = $false }
    }
}
