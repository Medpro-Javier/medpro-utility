# ---------------------------------------------------------------------------
# Startup gates.
#
# Runs before anything touches the system. Each gate either passes or stops the
# script with an explanation a technician can act on - never a bare exception.
# ---------------------------------------------------------------------------

$ErrorActionPreference = "Stop"

function Write-MedProStartupError {
    param([string]$Message)
    Write-Host ""
    Write-Host "  MedPro Utility cannot start" -ForegroundColor Red
    Write-Host "  $Message" -ForegroundColor Yellow
    Write-Host ""
}

# --- Gate 1: Windows 11 -----------------------------------------------------
# Build 22000 is the first Windows 11 release. Every tweak in this tool was
# authored and verified against Windows 11 registry paths; several of them
# write to keys that mean something different (or nothing) on Windows 10.
$build = [System.Environment]::OSVersion.Version.Build
if ($build -lt 22000) {
    Write-MedProStartupError "This tool targets Windows 11 only. This machine reports build $build."
    return
}

# --- Gate 2: administrator ---------------------------------------------------
# Registry writes under HKLM, service changes, appx provisioning removal, and
# domain join all require elevation. Relaunch rather than fail.
$identity  = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($identity)
$isAdmin   = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# --- Gate 3: STA apartment ---------------------------------------------------
# WPF will not create a window on an MTA thread. Windows PowerShell 5.1 is STA
# by default; pwsh is MTA by default, which is the usual reason this trips.
$isSta = [System.Threading.Thread]::CurrentThread.GetApartmentState() -eq [System.Threading.ApartmentState]::STA

if (-not $isAdmin -or -not $isSta) {
    $reason = if (-not $isAdmin) { "administrator rights" } else { "an STA thread for the interface" }
    Write-Host "  MedPro Utility needs $reason - relaunching..." -ForegroundColor Cyan

    # Prefer relaunching the local file. When the tool arrived via `irm | iex`
    # there is no file on disk, so re-fetch from the published URL instead.
    $localPath = if ($PSCommandPath) { $PSCommandPath } elseif ($MyInvocation.MyCommand.Path) { $MyInvocation.MyCommand.Path } else { $null }

    $relaunchArgs = @("-NoProfile", "-ExecutionPolicy", "Bypass", "-STA")
    if ($localPath -and (Test-Path -LiteralPath $localPath)) {
        $relaunchArgs += @("-File", "`"$localPath`"")
    } else {
        $relaunchArgs += @("-Command", "irm $($sync.launchUrl) | iex")
    }

    try {
        # Always relaunch into powershell.exe: it ships with every Windows 11
        # install and defaults to STA, so this cannot land back on Gate 3.
        Start-Process powershell.exe -ArgumentList $relaunchArgs -Verb RunAs
    } catch {
        Write-MedProStartupError "The elevation prompt was declined or blocked. Right-click PowerShell, choose 'Run as administrator', and try again."
    }
    return
}

# --- Working directories -----------------------------------------------------
foreach ($dir in @($sync.logPath, $sync.cachePath)) {
    if (-not (Test-Path -LiteralPath $dir)) {
        New-Item -Path $dir -ItemType Directory -Force | Out-Null
    }
}

# --- Transcript --------------------------------------------------------------
# Everything this tool does to a machine is recorded. When a technician reports
# "it broke something", this log is the answer.
$sync.logFile = Join-Path $sync.logPath ("medproutil-{0}.log" -f (Get-Date -Format "yyyyMMdd-HHmmss"))
try {
    Start-Transcript -Path $sync.logFile -Force | Out-Null
    $sync.transcriptRunning = $true
} catch {
    # A failed transcript is not worth blocking provisioning over.
    $sync.transcriptRunning = $false
    Write-Host "  Could not start the transcript log: $($_.Exception.Message)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "  MedPro Utility $($sync.version)" -ForegroundColor Cyan
Write-Host "  Windows build $build | log: $($sync.logFile)" -ForegroundColor DarkGray
Write-Host ""
