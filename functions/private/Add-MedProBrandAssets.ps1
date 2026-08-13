function Add-MedProBrandAssets {
    <#
    .SYNOPSIS
        Puts the official MedPro mark into the window header.

    .DESCRIPTION
        The brand guidelines are explicit that the logo is used as supplied and
        never redrawn, so the header shows the real artwork rather than the
        wordmark set in whatever font happens to be installed.

        The image comes from $sync.assets, which Compile.ps1 fills with base64
        at build time - that keeps the single-file build self-contained and
        pure ASCII. Running from the repo there is no build step, so the file
        under assets/ is used directly.

        A missing logo is not worth failing over: the header simply collapses
        the image and the rest of the window is unaffected.

    .EXAMPLE
        Add-MedProBrandAssets
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.MedProLogo) { return }

    $bytes = $null

    # Compile.ps1 derives the key from the file name: logo-medpro.png -> logoMedpro.
    if ($sync.assets -and $sync.assets.logoMedpro) {
        try { $bytes = [Convert]::FromBase64String($sync.assets.logoMedpro) } catch { }
    }

    if (-not $bytes) {
        # Repo layout: functions/private/<this file> -> ../../assets
        $root = if ($PSScriptRoot) { Split-Path (Split-Path $PSScriptRoot -Parent) -Parent } else { $null }
        $path = if ($root) { Join-Path $root "assets\logo-medpro.png" } else { $null }
        if ($path -and (Test-Path $path)) {
            try { $bytes = [System.IO.File]::ReadAllBytes($path) } catch { }
        }
    }

    if (-not $bytes) {
        $sync.MedProLogo.Visibility = [System.Windows.Visibility]::Collapsed
        Write-MedProLog "The MedPro logo could not be loaded, so the header is showing without it." -Level Warning
        return
    }

    try {
        $stream = New-Object System.IO.MemoryStream(,$bytes)
        $image  = New-Object System.Windows.Media.Imaging.BitmapImage
        $image.BeginInit()
        # Read the stream out now: the caller disposes it, and a lazily-loaded
        # BitmapImage would then have nothing left to decode.
        $image.CacheOption  = [System.Windows.Media.Imaging.BitmapCacheOption]::OnLoad
        $image.StreamSource = $stream
        $image.EndInit()
        $image.Freeze()
        $stream.Dispose()

        $sync.MedProLogo.Source = $image
    } catch {
        $sync.MedProLogo.Visibility = [System.Windows.Visibility]::Collapsed
        Write-MedProLog "The MedPro logo could not be decoded: $($_.Exception.Message)" -Level Warning
    }
}
