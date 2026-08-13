function Connect-MedProShare {
    <#
    .SYNOPSIS
        Makes sure the UNC shares an install run needs are reachable, prompting once.

    .DESCRIPTION
        A freshly imaged machine is often not domain joined yet, so \\med-dc-01\Install
        may refuse it. Rather than let those installs fail one by one, this checks
        access up front and prompts the technician once per share.

        Must be called on the UI thread. Get-Credential shows a dialog, and a
        dialog raised from a background runspace is one nobody ever sees - which
        is why this is a pre-flight step rather than something Get-MedProShareFile
        does for itself.

        The credential is used to map the share for the session and is not stored
        anywhere afterwards. Nothing is written to config, the repository, or the
        transcript.

    .PARAMETER Path
        One or more UNC paths that the run is about to need.

    .OUTPUTS
        Hashtable of share root to $true/$false accessibility.

    .EXAMPLE
        $access = Connect-MedProShare -Path @("\\med-dc-01\Install\Ricoh\setup.exe")
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        [AllowEmptyString()]
        [string[]]$Path
    )

    $access = @{}
    if (-not $sync.MappedShares) { $sync.MappedShares = New-Object System.Collections.Generic.List[string] }

    # Reduce a set of file paths to the distinct \\server\share roots behind them,
    # so two installers on one share only prompt once.
    $roots = @($Path |
        Where-Object { $_ -like "\\*" } |
        ForEach-Object { if ($_ -match '^(\\\\[^\\]+\\[^\\]+)') { $Matches[1] } } |
        Sort-Object -Unique)

    foreach ($root in $roots) {

        if (Test-Path -LiteralPath $root -ErrorAction SilentlyContinue) {
            Write-MedProLog "$root is reachable."
            $access[$root] = $true
            continue
        }

        Write-MedProLog "$root is not reachable with this machine's current credentials." -Level Warning

        $credential = Get-Credential -Message "Enter credentials with read access to $root"
        if (-not $credential) {
            Write-MedProLog "No credentials entered - applications on $root will be skipped." -Level Warning
            $access[$root] = $false
            continue
        }

        try {
            # A temporary, uniquely named PSDrive. Naming it after the share would
            # collide if the technician already has one mapped.
            $driveName = "MedProShare$($sync.MappedShares.Count)"

            New-PSDrive -Name $driveName -PSProvider FileSystem -Root $root `
                        -Credential $credential -Scope Global -ErrorAction Stop | Out-Null

            $sync.MappedShares.Add($driveName)

            # New-PSDrive succeeding authenticates the session to that server, so
            # the original UNC path works from here on without rewriting it.
            $access[$root] = [bool](Test-Path -LiteralPath $root -ErrorAction SilentlyContinue)

            if ($access[$root]) {
                Write-MedProLog "Connected to $root." -Level Success
            } else {
                Write-MedProLog "Mapped $root but still cannot read it." -Level Error
            }

        } catch {
            Write-MedProLog "Could not connect to $root - $($_.Exception.Message)" -Level Error
            $access[$root] = $false
        } finally {
            $credential = $null
        }
    }

    return $access
}
