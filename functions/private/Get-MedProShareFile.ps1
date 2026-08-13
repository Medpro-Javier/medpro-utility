function Get-MedProShareFile {
    <#
    .SYNOPSIS
        Copies an installer from a UNC share (or local path) into the local cache.

    .DESCRIPTION
        MedPro's line-of-business installers live on \\med-dc-01\Install rather
        than on a vendor URL. They are copied locally before being run rather than
        executed straight off the share, for two reasons:

          - A 284 MB installer streamed over SMB is where installs fail. An
            installer that loses its own file part-way through does not fail
            cleanly, it fails strangely.
          - Some installers extract alongside themselves and need write access to
            their own directory, which a read-only share does not give them.

        If the share needs credentials, the caller is expected to have mapped it
        already via Connect-MedProShare on the UI thread. This function does not
        prompt, because it may be running in a background runspace where a
        credential dialog would never be seen.

        Returns $null on any failure so the caller falls through to its next
        source, exactly like a failed download.

    .PARAMETER Path
        UNC or local path to the installer.

    .PARAMETER FileName
        Name to save as inside the cache folder.

    .OUTPUTS
        [string] Full path to the local copy, or $null.

    .EXAMPLE
        $local = Get-MedProShareFile -Path $app.path -FileName "MedProInstallRicoh.exe"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][string]$FileName
    )

    if (-not (Test-Path -LiteralPath $sync.cachePath)) {
        New-Item -Path $sync.cachePath -ItemType Directory -Force | Out-Null
    }

    $destination = Join-Path $sync.cachePath $FileName

    try {
        if (-not (Test-Path -LiteralPath $Path)) {
            throw "the file was not found, or this machine has no access to the share"
        }

        $source = Get-Item -LiteralPath $Path -ErrorAction Stop
        Write-MedProLog "  copying $([math]::Round($source.Length / 1MB, 1)) MB from $Path..."

        if (Test-Path -LiteralPath $destination) {
            Remove-Item -LiteralPath $destination -Force -ErrorAction SilentlyContinue
        }

        Copy-Item -LiteralPath $Path -Destination $destination -Force -ErrorAction Stop

        # A copy that was interrupted mid-flight leaves a short file rather than
        # an error, so the size is confirmed rather than assumed.
        $copied = Get-Item -LiteralPath $destination -ErrorAction Stop
        if ($copied.Length -ne $source.Length) {
            throw "the copy is incomplete - $($copied.Length) of $($source.Length) bytes"
        }

        Write-MedProLog "  copied locally"
        return $destination

    } catch {
        Write-MedProLog "  could not get $Path - $($_.Exception.Message)" -Level Warning
        if (Test-Path -LiteralPath $destination) {
            Remove-Item -LiteralPath $destination -Force -ErrorAction SilentlyContinue
        }
        return $null
    }
}
