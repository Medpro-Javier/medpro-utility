function Get-MedProDownload {
    <#
    .SYNOPSIS
        Downloads an installer to the local cache, with retries and hash checking.

    .DESCRIPTION
        Vendor download links are the primary install source for MedPro Utility,
        which means download reliability is install reliability. This handles the
        three things that actually go wrong on a technician's machine:

          - a transient network failure on a fresh Wi-Fi connection, so it retries
          - a link that has silently become a redirect to an HTML error page, so
            the response has to be a real file of plausible size
          - a modified or truncated payload, so an expected SHA256 is verified
            before anything is executed

        A failure returns $null rather than throwing. The caller treats that as
        "fall back to winget", which is the whole point of having a fallback.

    .PARAMETER Url
        Direct download URL.

    .PARAMETER FileName
        Name to save as inside the cache folder.

    .PARAMETER Sha256
        Optional expected hash. When supplied, a mismatch fails the download.

    .PARAMETER Attempts
        How many times to try before giving up.

    .OUTPUTS
        [string] Full path to the downloaded file, or $null on failure.

    .EXAMPLE
        $path = Get-MedProDownload -Url $app.url -FileName "chrome.msi" -Sha256 $app.sha256
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Url,
        [Parameter(Mandatory)][string]$FileName,
        [string]$Sha256,
        [int]$Attempts = 3
    )

    if (-not (Test-Path -LiteralPath $sync.cachePath)) {
        New-Item -Path $sync.cachePath -ItemType Directory -Force | Out-Null
    }

    $destination = Join-Path $sync.cachePath $FileName

    # Some vendor CDNs still negotiate down without this on older hosts.
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13
    } catch {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    }

    for ($attempt = 1; $attempt -le $Attempts; $attempt++) {

        if (Test-Path -LiteralPath $destination) { Remove-Item -LiteralPath $destination -Force -ErrorAction SilentlyContinue }

        try {
            Write-MedProLog "  downloading $FileName$(if ($attempt -gt 1) { " (attempt $attempt of $Attempts)" })..."

            # Invoke-WebRequest's progress rendering costs more time than the
            # transfer on large files, so it is turned off for the duration.
            $previousProgress = $ProgressPreference
            $ProgressPreference = "SilentlyContinue"
            try {
                Invoke-WebRequest -Uri $Url -OutFile $destination -UseBasicParsing -TimeoutSec 300 -ErrorAction Stop
            } finally {
                $ProgressPreference = $previousProgress
            }

            if (-not (Test-Path -LiteralPath $destination)) { throw "the download produced no file" }

            $size = (Get-Item -LiteralPath $destination).Length

            # A dead link that redirects to a branded error page returns HTTP 200
            # and a few kilobytes of HTML. Treat anything implausibly small as a
            # failure rather than handing it to msiexec.
            if ($size -lt 10KB) { throw "the download is only $size bytes - the link probably returned an error page" }

            if ($Sha256) {
                $actual = (Get-FileHash -LiteralPath $destination -Algorithm SHA256).Hash
                if ($actual -ne $Sha256.ToUpper()) {
                    throw "SHA256 mismatch - expected $($Sha256.ToUpper()), got $actual"
                }
                Write-MedProLog "  hash verified"
            }

            Write-MedProLog "  downloaded $([math]::Round($size / 1MB, 1)) MB"
            return $destination

        } catch {
            Write-MedProLog "  download failed - $($_.Exception.Message)" -Level Warning
            if ($attempt -lt $Attempts) { Start-Sleep -Seconds (2 * $attempt) }
        }
    }

    if (Test-Path -LiteralPath $destination) { Remove-Item -LiteralPath $destination -Force -ErrorAction SilentlyContinue }
    return $null
}
