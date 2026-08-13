function Invoke-MedProJoinDomainButton {
    <#
    .SYNOPSIS
        Joins this machine to the MedPro domain, prompting for credentials.

    .DESCRIPTION
        Bound to MedProJoinDomainButton.

        Get-Credential shows Windows' own secure prompt. The technician types the
        credentials into that dialog; the resulting object is held only for the
        duration of the join and cleared immediately afterwards. Nothing is
        written to the config, the repository, or the transcript.
    #>
    [CmdletBinding()]
    param()

    $domain = $sync.configs.provisioning.domain

    if ($domain.configured -ne $true -or [string]::IsNullOrWhiteSpace($domain.name)) {
        [System.Windows.MessageBox]::Show(
            "The domain is not configured yet.`n`nSet 'name', 'ouPath', and 'configured': true in the domain section of config/provisioning.json, then rebuild with .\Compile.ps1.",
            "MedPro Utility",
            [System.Windows.MessageBoxButton]::OK,
            [System.Windows.MessageBoxImage]::Information) | Out-Null
        Write-MedProLog "Domain join skipped - config/provisioning.json has no domain configured." -Level Warning
        return
    }

    $credential = Get-Credential -Message "Enter an account with rights to join $($domain.name)."
    if (-not $credential) {
        Write-MedProLog "Domain join cancelled - no credentials entered."
        return
    }

    try {
        Set-MedProUIState -Enabled $false -Status "Joining $($domain.name)..."
        $result = Join-MedProDomain -Credential $credential
    } finally {
        # The credential object goes out of scope here and is not stored anywhere.
        $credential = $null
        [System.GC]::Collect()
        Set-MedProUIState -Enabled $true -Status "Ready"
    }

    if ($result.RebootRequired) { $sync.RebootPending = $true }

    $icon = if ($result.Success) {
        [System.Windows.MessageBoxImage]::Information
    } else {
        [System.Windows.MessageBoxImage]::Warning
    }

    [System.Windows.MessageBox]::Show(
        $result.Message, "MedPro Utility",
        [System.Windows.MessageBoxButton]::OK, $icon) | Out-Null
}
