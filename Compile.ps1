<#
.SYNOPSIS
    Builds MedPro Utility into a single, self-contained, distributable script.

.DESCRIPTION
    Aggregates every function under functions/, every JSON file under config/,
    and the WPF layout in xaml/ into one output file (medproutil.ps1). That
    single file is what technicians run, either from disk or via:

        irm <LaunchUrl> | iex

    Only functions whose file content contains "MedPro" are picked up. This is
    deliberate: it keeps the build dumb and predictable, and makes it obvious
    when a helper has drifted from the naming convention.

.PARAMETER OutputFile
    Path of the compiled script. Defaults to medproutil.ps1 in the repo root.

.PARAMETER Version
    Version stamped into the output banner and $sync.version.

.PARAMETER LaunchUrl
    URL the compiled script re-invokes when it needs to relaunch itself
    elevated and no local file path is available (the `irm | iex` case).

.PARAMETER Run
    Launch the compiled script immediately after a successful build.

.EXAMPLE
    .\Compile.ps1
    .\Compile.ps1 -Run
#>
[CmdletBinding()]
param(
    [string]$OutputFile = "medproutil.ps1",
    [string]$Version     = "1.0.0",
    [string]$LaunchUrl   = "https://raw.githubusercontent.com/MedProStaffing/medpro-utility/main/medproutil.ps1",
    [switch]$Run
)

$ErrorActionPreference = "Stop"
$root = $PSScriptRoot

function Write-Step   { param($Message) Write-Host "  $Message" -ForegroundColor DarkGray }
function Write-Ok     { param($Message) Write-Host "  $Message" -ForegroundColor Green }
function Write-Header { param($Message) Write-Host "`n$Message" -ForegroundColor Cyan }

# Embedded content lives inside single-quoted here-strings. A line that begins
# with '@ would terminate one early and produce a syntactically valid but
# completely wrong script, so refuse to build rather than ship that.
function Assert-HereStringSafe {
    param([string]$Content, [string]$Source)

    $offending = ($Content -split "`r?`n") |
        Select-String -Pattern "^\s*'@" |
        Select-Object -First 1

    if ($offending) {
        throw "$Source contains a line starting with '@ (line $($offending.LineNumber)), which would terminate the embedded here-string. Reformat that line."
    }
}

# The Undo button is only as good as the data behind it. A tweak that changes
# something with no recorded way back is a defect, so the build refuses it
# rather than letting it reach a technician's machine.
function Assert-TweaksReversible {
    param($Tweaks)

    $problems = New-Object System.Collections.Generic.List[string]

    foreach ($property in $Tweaks.PSObject.Properties) {
        $name  = $property.Name
        $tweak = $property.Value

        # One-shot actions (Disk Cleanup, flush DNS) genuinely have nothing to reverse.
        if ($tweak.action -eq $true) { continue }

        foreach ($entry in @($tweak.registry)) {
            if ($null -eq $entry) { continue }
            if ($null -eq $entry.OriginalValue) {
                $problems.Add("$name -> registry $($entry.Path)\$($entry.Name) has no OriginalValue")
            }
        }

        foreach ($entry in @($tweak.service)) {
            if ($null -eq $entry) { continue }
            if ($null -eq $entry.OriginalType) {
                $problems.Add("$name -> service $($entry.Name) has no OriginalType")
            }
        }

        if ($tweak.InvokeScript -and -not $tweak.UndoScript) {
            $problems.Add("$name has an InvokeScript but no UndoScript")
        }
    }

    if ($problems.Count -gt 0) {
        Write-Host "`nBUILD FAILED - these tweaks cannot be undone:" -ForegroundColor Red
        $problems | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
        throw "$($problems.Count) tweak(s) are not reversible. Add OriginalValue/OriginalType/UndoScript, or mark the tweak as an action."
    }

    Write-Step "  all tweaks are reversible"
}

# An application with no install source at all is a catalog typo that would
# otherwise only surface as a failed install on a technician's machine.
function Assert-ApplicationsInstallable {
    param($Applications)

    $problems = New-Object System.Collections.Generic.List[string]

    foreach ($property in $Applications.PSObject.Properties) {
        $name = $property.Name
        $app  = $property.Value

        if (-not $app.path -and -not $app.url -and -not $app.winget) {
            $problems.Add("$name has no path, url, or winget source")
        }

        # A local file source needs to know how to run it; winget-only entries do not.
        if (($app.path -or $app.url) -and -not $app.type) {
            $problems.Add("$name has a file source but no type (msi, exe, msix)")
        }

        if ($app.path -and $app.path -notlike "\\*" -and $app.path -notmatch '^[A-Za-z]:\\') {
            $problems.Add("$name has a path that is neither a UNC share nor an absolute local path: $($app.path)")
        }
    }

    if ($problems.Count -gt 0) {
        Write-Host "`nBUILD FAILED - these applications cannot be installed:" -ForegroundColor Red
        $problems | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
        throw "$($problems.Count) invalid application entr(ies)."
    }

    Write-Step "  every application has a usable source"
}

Write-Header "MedPro Utility - build $Version"

# --------------------------------------------------------------------------
# 1. Configuration
# --------------------------------------------------------------------------
Write-Header "Configuration"

$configDir = Join-Path $root "config"
$configs   = [ordered]@{}

if (Test-Path $configDir) {
    foreach ($file in Get-ChildItem -Path $configDir -Filter "*.json" | Sort-Object Name) {
        $raw = Get-Content -Path $file.FullName -Raw

        # Parse now so a malformed config fails the build instead of the tech's machine.
        try {
            $null = $raw | ConvertFrom-Json
        } catch {
            throw "config/$($file.Name) is not valid JSON: $($_.Exception.Message)"
        }

        Assert-HereStringSafe -Content $raw -Source "config/$($file.Name)"

        if ($file.BaseName -eq "tweaks") {
            Assert-TweaksReversible -Tweaks ($raw | ConvertFrom-Json)
        }
        if ($file.BaseName -eq "applications") {
            Assert-ApplicationsInstallable -Applications ($raw | ConvertFrom-Json)
        }

        $configs[$file.BaseName] = $raw
        Write-Step "config/$($file.Name)"
    }
}

if ($configs.Count -eq 0) { Write-Step "(none yet)" }

# Presets reference keys in the other configs by name. A rename on one side
# leaves a preset that silently selects less than it claims to, which on a
# provisioning run means an under-configured machine nobody notices.
if ($configs.Contains("preset")) {
    $presets = $configs["preset"] | ConvertFrom-Json

    $known = @{
        tweaks       = if ($configs.Contains("tweaks"))       { ($configs["tweaks"]       | ConvertFrom-Json).PSObject.Properties.Name } else { @() }
        applications = if ($configs.Contains("applications")) { ($configs["applications"] | ConvertFrom-Json).PSObject.Properties.Name } else { @() }
        debloat      = if ($configs.Contains("debloat"))      { ($configs["debloat"]      | ConvertFrom-Json).groups.PSObject.Properties.Name } else { @() }
    }

    $dangling = New-Object System.Collections.Generic.List[string]

    foreach ($property in $presets.PSObject.Properties) {
        foreach ($section in @("tweaks", "applications", "debloat")) {
            foreach ($key in @($property.Value.$section)) {
                if ($known[$section] -notcontains $key) {
                    $dangling.Add("$($property.Name) -> $section -> $key")
                }
            }
        }
    }

    if ($dangling.Count -gt 0) {
        Write-Host "`nBUILD FAILED - presets reference keys that do not exist:" -ForegroundColor Red
        $dangling | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
        throw "$($dangling.Count) dangling preset reference(s)."
    }

    Write-Step "  all preset references resolve"
}

# --------------------------------------------------------------------------
# 2. Functions
# --------------------------------------------------------------------------
Write-Header "Functions"

$functionText = New-Object System.Text.StringBuilder
$functionCount = 0
$skipped = @()

foreach ($scope in @("private", "public")) {
    $scopeDir = Join-Path $root "functions\$scope"
    if (-not (Test-Path $scopeDir)) { continue }

    foreach ($file in Get-ChildItem -Path $scopeDir -Filter "*.ps1" -Recurse | Sort-Object FullName) {
        $raw = Get-Content -Path $file.FullName -Raw

        if ($raw -notmatch "MedPro") {
            $skipped += "functions/$scope/$($file.Name)"
            continue
        }

        [void]$functionText.AppendLine("#region $scope/$($file.Name)")
        [void]$functionText.AppendLine($raw.TrimEnd())
        [void]$functionText.AppendLine("#endregion")
        [void]$functionText.AppendLine()

        $functionCount++
        Write-Step "$scope/$($file.Name)"
    }
}

if ($functionCount -eq 0) { Write-Step "(none yet)" }

foreach ($s in $skipped) {
    Write-Host "  SKIPPED $s - no 'MedPro' in the file, so it will not be in the build." -ForegroundColor Yellow
}

# --------------------------------------------------------------------------
# 3. XAML
# --------------------------------------------------------------------------
Write-Header "Interface"

$xamlPath = Join-Path $root "xaml\inputXML.xaml"
if (-not (Test-Path $xamlPath)) { throw "Missing xaml/inputXML.xaml - there is no interface to build." }

$xaml = Get-Content -Path $xamlPath -Raw
Assert-HereStringSafe -Content $xaml -Source "xaml/inputXML.xaml"

# XamlReader is fed through XmlNodeReader, so the layout has to be well-formed
# XML first. Catching that here beats catching it on a technician's machine.
# The usual offender is a section comment containing a run of dashes.
try {
    $null = [xml]$xaml
} catch {
    throw "xaml/inputXML.xaml is not well-formed XML: $($_.Exception.Message)"
}

# XamlReader cannot load a compiled-code-behind window, so these must not survive.
if ($xaml -match 'x:Class\s*=') { throw "xaml/inputXML.xaml declares x:Class. Remove it - XamlReader::Load cannot resolve code-behind." }
if ($xaml -match 'mc:Ignorable') { throw "xaml/inputXML.xaml declares mc:Ignorable. Remove it and the design-time namespaces." }

Write-Step "xaml/inputXML.xaml"

# --------------------------------------------------------------------------
# 3b. Brand assets
#
# The MedPro mark ships inside the build rather than being fetched or redrawn,
# so the tool is still on-brand on a machine with no network and no font kit.
# Base64 keeps the single-file script pure ASCII.
# --------------------------------------------------------------------------
Write-Header "Brand assets"

$assetDir = Join-Path $root "assets"
$assets   = [ordered]@{}

if (Test-Path $assetDir) {
    foreach ($file in Get-ChildItem -Path $assetDir -Filter "*.png" | Sort-Object Name) {
        # logo-medpro.png -> logoMedPro
        $parts = $file.BaseName -split "[-_]"
        $key   = $parts[0] + (($parts | Select-Object -Skip 1 | ForEach-Object {
            if ($_.Length -gt 0) { $_.Substring(0,1).ToUpper() + $_.Substring(1) }
        }) -join "")

        $assets[$key] = [Convert]::ToBase64String([System.IO.File]::ReadAllBytes($file.FullName))
        Write-Step "assets/$($file.Name) -> `$sync.assets.$key ($([int]($file.Length/1kb)) KB)"
    }
}

if ($assets.Count -eq 0) { Write-Step "(none yet)" }

# --------------------------------------------------------------------------
# 4. Scripts
# --------------------------------------------------------------------------
Write-Header "Scripts"

function Get-ScriptBody {
    param([string]$Name)
    $path = Join-Path $root "scripts\$Name"
    if (-not (Test-Path $path)) { throw "Missing scripts/$Name" }
    Write-Step "scripts/$Name"
    return (Get-Content -Path $path -Raw).TrimEnd()
}

$startBody = Get-ScriptBody "start.ps1"
$mainBody  = Get-ScriptBody "main.ps1"

# --------------------------------------------------------------------------
# 5. Assemble
# --------------------------------------------------------------------------
Write-Header "Assembling"

$out = New-Object System.Text.StringBuilder

[void]$out.AppendLine(@"
<#
================================================================================
  MedPro Utility $Version
  Windows 11 provisioning, optimization, and debloat tool.

  GENERATED FILE - DO NOT EDIT.
  Edit the sources under config/, functions/, scripts/, and xaml/, then run
  .\Compile.ps1 to regenerate this file.

  Copyright (c) 2026 MedPro Healthcare Staffing. MIT Licensed.
  Portions derived from WinUtil by Chris Titus Tech (MIT). See NOTICE.md.
================================================================================
#>

`$sync = [Hashtable]::Synchronized(@{})
`$sync.version   = "$Version"
`$sync.launchUrl = "$LaunchUrl"
`$sync.logPath   = "`$env:ProgramData\MedProUtility\logs"
`$sync.cachePath = "`$env:ProgramData\MedProUtility\cache"
`$sync.configs   = @{}
`$sync.assets    = @{}
`$sync.ProcessRunning = `$false
"@)

# --- brand assets ---
if ($assets.Count -gt 0) {
    [void]$out.AppendLine("#region Brand assets")
    foreach ($name in $assets.Keys) {
        [void]$out.AppendLine("`$sync.assets.$name = '$($assets[$name])'")
    }
    [void]$out.AppendLine("#endregion")
    [void]$out.AppendLine()
}

# --- configs ---
[void]$out.AppendLine("#region Configuration")
foreach ($name in $configs.Keys) {
    [void]$out.AppendLine("`$sync.configs.$name = @'")
    [void]$out.AppendLine($configs[$name].TrimEnd())
    [void]$out.AppendLine("'@ | ConvertFrom-Json")
    [void]$out.AppendLine()
}
[void]$out.AppendLine("#endregion")
[void]$out.AppendLine()

# --- xaml ---
[void]$out.AppendLine("#region Interface")
[void]$out.AppendLine("`$sync.xamlText = @'")
[void]$out.AppendLine($xaml.TrimEnd())
[void]$out.AppendLine("'@")
[void]$out.AppendLine("#endregion")
[void]$out.AppendLine()

# --- functions ---
[void]$out.AppendLine("#region Functions")
[void]$out.AppendLine($functionText.ToString().TrimEnd())
[void]$out.AppendLine("#endregion")
[void]$out.AppendLine()

# --- start: gates and elevation, before anything touches the system ---
[void]$out.AppendLine("#region Startup")
[void]$out.AppendLine($startBody)
[void]$out.AppendLine("#endregion")
[void]$out.AppendLine()

# --- main: build and show the window ---
[void]$out.AppendLine("#region Main")
[void]$out.AppendLine($mainBody)
[void]$out.AppendLine("#endregion")

$outputPath = if ([System.IO.Path]::IsPathRooted($OutputFile)) { $OutputFile } else { Join-Path $root $OutputFile }

# BOM-less UTF8 keeps `irm | iex` from choking on a leading byte-order mark.
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($outputPath, $out.ToString(), $utf8NoBom)

# --------------------------------------------------------------------------
# 6. Verify the output actually parses
# --------------------------------------------------------------------------
$parseErrors = $null
[System.Management.Automation.Language.Parser]::ParseFile($outputPath, [ref]$null, [ref]$parseErrors) | Out-Null

if ($parseErrors -and $parseErrors.Count -gt 0) {
    Write-Host "`nBUILD FAILED - the generated script does not parse:" -ForegroundColor Red
    $parseErrors | Select-Object -First 10 | ForEach-Object {
        Write-Host "  line $($_.Extent.StartLineNumber): $($_.Message)" -ForegroundColor Red
    }
    throw "Generated script has $($parseErrors.Count) parse error(s)."
}

$sizeKb = [math]::Round((Get-Item $outputPath).Length / 1KB, 1)
Write-Ok "$OutputFile - $sizeKb KB, $($configs.Count) config(s), $functionCount function file(s)"

if ($Run) {
    Write-Header "Launching"
    Start-Process powershell.exe -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$outputPath`"" -Verb RunAs
}
