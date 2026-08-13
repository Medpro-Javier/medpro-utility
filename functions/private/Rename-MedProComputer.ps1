function Rename-MedProComputer {
    <#
    .SYNOPSIS
        Renames the machine, validating against the MedPro naming standard first.

    .DESCRIPTION
        The technician types whatever name the machine should have. MedPro has no
        naming pattern, so none is invented or enforced here - only Windows' own
        rules, which are real constraints rather than local policy:

          - the NetBIOS 15-character limit and its illegal characters, which
            Windows enforces but reports unhelpfully
          - a name that is all digits, which Windows rejects
          - whether the machine already has that name, which makes this a no-op
            rather than an unnecessary reboot

    .PARAMETER NewName
        The proposed computer name.

    .OUTPUTS
        Result object with Success, Message, and RebootRequired.

    .EXAMPLE
        Rename-MedProComputer -NewName "MP-MIA-0142"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$NewName
    )

    $NewName = $NewName.Trim()
    $fail = { param($Reason) [PSCustomObject]@{ Success = $false; Message = $Reason; RebootRequired = $false } }

    if ([string]::IsNullOrWhiteSpace($NewName)) {
        return & $fail "No name was entered."
    }

    # NetBIOS limits. Windows enforces these but reports them poorly.
    if ($NewName.Length -gt 15) {
        return & $fail "'$NewName' is $($NewName.Length) characters. Windows computer names are limited to 15."
    }
    if ($NewName -match '[^a-zA-Z0-9\-]') {
        return & $fail "'$NewName' contains characters that are not allowed. Use letters, numbers, and hyphens only."
    }
    if ($NewName -match '^\d+$') {
        return & $fail "'$NewName' is all digits, which Windows does not allow as a computer name."
    }

    if ($NewName -eq $env:COMPUTERNAME) {
        return [PSCustomObject]@{
            Success = $true
            Message = "This machine is already named $NewName - nothing to do."
            RebootRequired = $false
        }
    }

    try {
        Write-MedProLog "Renaming $env:COMPUTERNAME to $NewName..."
        Rename-Computer -NewName $NewName -Force -ErrorAction Stop

        Write-MedProLog "Renamed to $NewName. The change takes effect after a reboot." -Level Success
        return [PSCustomObject]@{
            Success = $true
            Message = "Renamed to $NewName. Reboot to apply."
            RebootRequired = $true
        }

    } catch {
        Write-MedProLog "Rename failed: $($_.Exception.Message)" -Level Error
        return & $fail $_.Exception.Message
    }
}
