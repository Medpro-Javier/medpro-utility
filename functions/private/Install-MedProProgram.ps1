function Install-MedProProgram {
    <#
    .SYNOPSIS
        Installs one application from the catalog: direct link first, winget second.

    .DESCRIPTION
        Sources are tried in order: path, then url, then winget. The order matters
        and is deliberate.

        A share path wins because MedPro put the file there on purpose - Ricoh
        drivers and the Kaseya agent are MedPro's own builds and have no public
        equivalent.

        The direct vendor link comes next because it is the version MedPro chose,
        fetched from the vendor rather than a third-party repository. winget is
        the fallback, so a link that rots overnight degrades a run to "installed
        a slightly different version" instead of "provisioning failed".

        Every fallback is logged as a warning rather than passed over quietly.
        A catalog whose links are quietly all dead still reports success on every
        app, which is exactly the failure mode this tool exists to prevent.

        Installer exit codes 3010 and 1641 mean success-pending-reboot, not
        failure. Treating them as errors is the most common way a working silent
        install gets reported as broken.

    .PARAMETER Name
        Catalog key, e.g. MedProInstallChrome.

    .PARAMETER App
        The parsed catalog entry.

    .OUTPUTS
        Result object with Name, Content, Status, Source, and RebootRequired.
        Status is Installed, AlreadyPresent, or Failed.

    .EXAMPLE
        Install-MedProProgram -Name "MedProInstallChrome" -App $sync.configs.applications.MedProInstallChrome
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Name,
        [Parameter(Mandatory)]$App
    )

    $label  = if ($App.content) { $App.content } else { $Name }
    $result = [PSCustomObject]@{
        Name           = $Name
        Content        = $label
        Status         = "Failed"
        Source         = "none"
        RebootRequired = $false
    }

    # Installer exit codes that mean the install worked.
    $successCodes = @(0, 3010, 1641)

    Write-MedProLog "$label"

    # --- Already there? -------------------------------------------------------
    if ($App.detect -and (Test-MedProInstalled -Detect $App.detect)) {
        Write-MedProLog "  already installed - skipped" -Level Success
        $result.Status = "AlreadyPresent"
        $result.Source = "existing"
        return $result
    }

    # --- File-based sources, in order of preference ---------------------------
    $type      = if ($App.type) { $App.type.ToLower() } else { "exe" }
    $extension = switch ($type) { "msi" { ".msi" } "msix" { ".msix" } "appx" { ".appx" } "msixbundle" { ".msixbundle" } default { ".exe" } }
    $fileName  = "$Name$extension"

    $sources = @()
    if ($App.path) { $sources += @{ Kind = "share";  Value = $App.path } }
    if ($App.url)  { $sources += @{ Kind = "direct"; Value = $App.url  } }

    foreach ($source in $sources) {

        $installer = switch ($source.Kind) {
            "share"  { Get-MedProShareFile -Path $source.Value -FileName $fileName }
            "direct" { Get-MedProDownload -Url $source.Value -FileName $fileName -Sha256 $App.sha256 }
        }

        if (-not $installer) { continue }

        try {
            if ($App.interactive -eq $true) {
                Write-MedProLog "  this installer is not silent - a technician needs to click through it" -Level Warning
            }

            $exitCode = Invoke-MedProInstaller -InstallerPath $installer -Type $type -Arguments $App.args

            if ($successCodes -contains $exitCode) {
                if ($exitCode -in @(3010, 1641)) {
                    $result.RebootRequired = $true
                    Write-MedProLog "  installed - a reboot is needed to finish" -Level Success
                } else {
                    $from = if ($source.Kind -eq "share") { "the MedPro share" } else { "the vendor link" }
                    Write-MedProLog "  installed from $from" -Level Success
                }
                $result.Status = "Installed"
                $result.Source = $source.Kind
                return $result
            }

            Write-MedProLog "  installer exited with code $exitCode" -Level Warning

        } catch {
            Write-MedProLog "  install failed - $($_.Exception.Message)" -Level Warning
        } finally {
            Remove-Item -LiteralPath $installer -Force -ErrorAction SilentlyContinue
        }
    }

    # --- winget fallback ------------------------------------------------------
    if (-not $App.winget) {
        $tried = if ($sources.Count) { "None of its sources worked" } else { "It has no install source" }
        Write-MedProLog "  FAILED - $tried and there is no winget fallback for this entry." -Level Error
        return $result
    }

    if ($sources.Count -gt 0) {
        Write-MedProLog "  falling back to winget - check the source in applications.json" -Level Warning
    }

    if (-not (Install-MedProWinget)) {
        Write-MedProLog "  FAILED - winget is unavailable on this machine." -Level Error
        return $result
    }

    # Machine scope first so the app is available to every user on a shared PC.
    # Not every package supports it, so a plain user-scope install is retried.
    $attempts = @(
        @("install", "--id", $App.winget, "--exact", "--silent", "--scope", "machine", "--accept-package-agreements", "--accept-source-agreements"),
        @("install", "--id", $App.winget, "--exact", "--silent", "--accept-package-agreements", "--accept-source-agreements")
    )

    foreach ($arguments in $attempts) {
        try {
            $output = & winget.exe @arguments 2>&1
            $exitCode = $LASTEXITCODE

            if ($successCodes -contains $exitCode) {
                Write-MedProLog "  installed via winget ($($App.winget))" -Level Success
                $result.Status = "Installed"
                $result.Source = "winget"
                return $result
            }

            # -1978335135 is "no applicable installer", which is what a
            # machine-scope request returns for a user-scope-only package.
            Write-MedProLog "  winget exited with code $exitCode" -Level Warning

        } catch {
            Write-MedProLog "  winget failed - $($_.Exception.Message)" -Level Warning
        }
    }

    Write-MedProLog "  FAILED - neither the vendor link nor winget could install this." -Level Error
    return $result
}
