function Remove-MedProAppx {
    <#
    .SYNOPSIS
        Removes an appx package for every user and deprovisions it for new profiles.

    .DESCRIPTION
        Removing a Store app properly takes two separate operations, and skipping
        either one is why debloat scripts appear not to work:

          Remove-AppxPackage -AllUsers      removes it from existing profiles
          Remove-AppxProvisionedPackage     stops Windows installing it into the
                                            next profile that signs in

        Patterns may contain wildcards, because package publisher prefixes and
        version suffixes vary between Windows builds and OEM images.

        The keep-list is enforced here rather than at the caller. Every resolved
        package name is checked against it before anything is removed, so a
        careless wildcard in the config cannot take out Windows Security, the
        Store, winget, or a framework package that other software depends on.

    .PARAMETER Pattern
        Package name patterns, e.g. "Microsoft.Xbox*" or "*CandyCrush*".

    .PARAMETER KeepList
        Patterns that must never be removed, regardless of what Pattern matches.

    .OUTPUTS
        A result object with Removed, Blocked, and Failed counts.

    .EXAMPLE
        Remove-MedProAppx -Pattern $group.packages -KeepList $sync.configs.debloat.keepList
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string[]]$Pattern,
        [string[]]$KeepList = @()
    )

    $removed = 0
    $blocked = 0
    $failed  = 0

    # Enumerated once rather than per pattern: Get-AppxPackage -AllUsers is slow
    # enough that calling it inside the loop is noticeable on a fresh image.
    #
    # Both -AllUsers and -Online require elevation. The tool gates on admin at
    # startup so this should never trip in normal use, but failing with a clear
    # sentence beats an UnauthorizedAccessException stack trace in the log.
    try {
        $installed   = @(Get-AppxPackage -AllUsers -ErrorAction Stop)
        $provisioned = @(Get-AppxProvisionedPackage -Online -ErrorAction Stop)
    } catch {
        Write-MedProLog "  cannot enumerate installed packages - $($_.Exception.Message)" -Level Error
        Write-MedProLog "  app removal needs an elevated session." -Level Error
        return [PSCustomObject]@{ Removed = 0; Blocked = 0; Failed = 1 }
    }

    foreach ($p in $Pattern) {
        if ([string]::IsNullOrWhiteSpace($p)) { continue }

        $matched = @($installed   | Where-Object { $_.Name -like $p }) +
                   @($provisioned | Where-Object { $_.DisplayName -like $p })

        if ($matched.Count -eq 0) { continue }

        $names = @($matched | ForEach-Object {
            if ($_.PSObject.Properties.Name -contains "DisplayName" -and $_.DisplayName) { $_.DisplayName } else { $_.Name }
        } | Sort-Object -Unique)

        foreach ($name in $names) {

            # The safety rail. A protected package is skipped and said out loud,
            # so an over-broad pattern shows up in the log rather than in a
            # support ticket a week later.
            $protectedBy = $KeepList | Where-Object { $name -like $_ } | Select-Object -First 1
            if ($protectedBy) {
                Write-MedProLog "  KEPT $name - protected by keep-list entry '$protectedBy'" -Level Warning
                $blocked++
                continue
            }

            $didSomething = $false

            foreach ($package in @($installed | Where-Object { $_.Name -eq $name })) {
                try {
                    Remove-AppxPackage -Package $package.PackageFullName -AllUsers -ErrorAction Stop
                    $didSomething = $true
                } catch {
                    Write-MedProLog "  could not remove $name for all users - $($_.Exception.Message)" -Level Warning
                    $failed++
                }
            }

            foreach ($package in @($provisioned | Where-Object { $_.DisplayName -eq $name })) {
                try {
                    Remove-AppxProvisionedPackage -Online -PackageName $package.PackageName -ErrorAction Stop | Out-Null
                    $didSomething = $true
                } catch {
                    Write-MedProLog "  could not deprovision $name - $($_.Exception.Message)" -Level Warning
                    $failed++
                }
            }

            if ($didSomething) {
                Write-MedProLog "  removed $name"
                $removed++
            }
        }
    }

    return [PSCustomObject]@{
        Removed = $removed
        Blocked = $blocked
        Failed  = $failed
    }
}
