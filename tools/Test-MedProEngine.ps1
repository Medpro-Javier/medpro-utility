<#
.SYNOPSIS
    Self-test for the MedPro Utility tweak engine.

.DESCRIPTION
    Exercises apply and undo against a scratch key under HKCU, covering the
    cases that actually break in practice: restoring a pre-existing value,
    removing a value that never existed, non-DWord types, one-shot actions, and
    config entries with no way back.

    Safe to run on any machine. It touches only
    HKCU:\Software\MedProUtilitySelfTest and removes that key when it finishes.
    Nothing here changes a real Windows setting, so it needs no elevation and no VM.

    Run this after changing anything under functions/private.

.EXAMPLE
    .\tools\Test-MedProEngine.ps1
#>
[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"
$repo = Split-Path $PSScriptRoot -Parent

$global:sync = [Hashtable]::Synchronized(@{})
$sync.configs = @{}
$sync.cachePath = Join-Path $env:TEMP "MedProUtilitySelfTest-cache"
foreach ($file in Get-ChildItem "$repo\functions" -Filter *.ps1 -Recurse) { . $file.FullName }

$testKey = "HKCU:\Software\MedProUtilitySelfTest"
if (Test-Path $testKey) { Remove-Item $testKey -Recurse -Force }

$script:passed = 0
$script:failed = 0

function Assert-MedProTest {
    param([string]$Label, [bool]$Condition)
    if ($Condition) {
        Write-Host "  PASS  $Label" -ForegroundColor Green
        $script:passed++
    } else {
        Write-Host "  FAIL  $Label" -ForegroundColor Red
        $script:failed++
    }
}

Write-Host "`nTweak engine self-test`n" -ForegroundColor Cyan

# --- A value that already exists is restored to what it was ------------------
New-Item -Path $testKey -Force | Out-Null
Set-ItemProperty -Path $testKey -Name "Existing" -Type DWord -Value 1

$tweakExisting = [PSCustomObject]@{
    Content  = "Self test - existing value"
    registry = @([PSCustomObject]@{ Path = $testKey; Name = "Existing"; Type = "DWord"; Value = "0"; OriginalValue = "1" })
}

Invoke-MedProTweak -Name "SelfTestExisting" -Tweak $tweakExisting -Mode Apply | Out-Null
Assert-MedProTest "apply writes the new value" ((Get-ItemProperty $testKey).Existing -eq 0)

Invoke-MedProTweak -Name "SelfTestExisting" -Tweak $tweakExisting -Mode Undo | Out-Null
Assert-MedProTest "undo restores the original value" ((Get-ItemProperty $testKey).Existing -eq 1)

# --- A value that did not exist is removed again, not zeroed -----------------
$tweakNew = [PSCustomObject]@{
    Content  = "Self test - new value"
    registry = @([PSCustomObject]@{ Path = "$testKey\Nested"; Name = "Created"; Type = "DWord"; Value = "1"; OriginalValue = "<RemoveEntry>" })
}

Invoke-MedProTweak -Name "SelfTestNew" -Tweak $tweakNew -Mode Apply | Out-Null
Assert-MedProTest "apply creates a missing key and value" ((Get-ItemProperty "$testKey\Nested").Created -eq 1)

Invoke-MedProTweak -Name "SelfTestNew" -Tweak $tweakNew -Mode Undo | Out-Null
Assert-MedProTest "undo removes a value that never existed" (
    $null -eq (Get-ItemProperty "$testKey\Nested" -Name "Created" -ErrorAction SilentlyContinue))

# --- String and Binary round-trip, since several real tweaks use both --------
$tweakTypes = [PSCustomObject]@{
    Content  = "Self test - types"
    registry = @(
        [PSCustomObject]@{ Path = $testKey; Name = "Str"; Type = "String"; Value = "0"; OriginalValue = "400" },
        [PSCustomObject]@{ Path = $testKey; Name = "Bin"; Type = "Binary"; Value = @(144, 18, 3, 128); OriginalValue = @(158, 30, 7, 128) }
    )
}

Invoke-MedProTweak -Name "SelfTestTypes" -Tweak $tweakTypes -Mode Apply | Out-Null
Assert-MedProTest "String value written" ((Get-ItemProperty $testKey).Str -eq "0")
Assert-MedProTest "Binary value written" ((((Get-ItemProperty $testKey).Bin) -join ',') -eq '144,18,3,128')

Invoke-MedProTweak -Name "SelfTestTypes" -Tweak $tweakTypes -Mode Undo | Out-Null
Assert-MedProTest "String value restored" ((Get-ItemProperty $testKey).Str -eq "400")
Assert-MedProTest "Binary value restored" ((((Get-ItemProperty $testKey).Bin) -join ',') -eq '158,30,7,128')

# --- A one-shot action must not pretend it reversed something ----------------
$tweakAction = [PSCustomObject]@{ Content = "Self test - action"; action = $true; InvokeScript = @("`$null = 1") }
$result = Invoke-MedProTweak -Name "SelfTestAction" -Tweak $tweakAction -Mode Undo
Assert-MedProTest "undo skips one-shot actions" ($result.Skipped -eq $true)

# --- A config entry with no way back must fail loudly ------------------------
$tweakBroken = [PSCustomObject]@{
    Content  = "Self test - broken"
    registry = @([PSCustomObject]@{ Path = $testKey; Name = "Existing"; Type = "DWord"; Value = "0" })
}
$result = Invoke-MedProTweak -Name "SelfTestBroken" -Tweak $tweakBroken -Mode Undo
Assert-MedProTest "undo without OriginalValue reports failure" ($result.Success -eq $false)

# --- A service this SKU does not have is not a failure -----------------------
Assert-MedProTest "missing service is tolerated" (Set-MedProService -Name "MedProDefinitelyNotAService" -StartupType Manual)

# --- Config sanity: every tweak the UI will show can be reversed -------------
$sync.configs.tweaks = Get-Content "$repo\config\tweaks.json" -Raw | ConvertFrom-Json
$irreversible = @()
foreach ($property in $sync.configs.tweaks.PSObject.Properties) {
    if ($property.Value.action -eq $true) { continue }
    foreach ($entry in @($property.Value.registry)) {
        if ($entry -and $null -eq $entry.OriginalValue) { $irreversible += $property.Name }
    }
}
Assert-MedProTest "every tweak in config/tweaks.json is reversible" ($irreversible.Count -eq 0)

# --- Debloat keep-list -------------------------------------------------------
# Every pattern below is on the keep-list, so this exercises the real removal
# path end to end while being incapable of removing anything.
$sync.configs.debloat = Get-Content "$repo\config\debloat.json" -Raw | ConvertFrom-Json
$keepList = @($sync.configs.debloat.keepList)

$critical = @(
    "Microsoft.SecHealthUI",        # Windows Security
    "Microsoft.DesktopAppInstaller",# winget itself
    "Microsoft.WindowsStore",
    "Microsoft.CompanyPortal",
    "MSTeams",
    "MicrosoftCorporationII.QuickAssist"
)

$unprotected = @($critical | Where-Object { $name = $_; -not ($keepList | Where-Object { $name -like $_ }) })
Assert-MedProTest "keep-list covers every business-critical package" ($unprotected.Count -eq 0)
if ($unprotected.Count) { Write-Host "        unprotected: $($unprotected -join ', ')" -ForegroundColor Red }

# Enumerating appx packages for all users needs elevation. The guard itself is
# still worth exercising for real, so run it when we can and say so when we cannot.
$isElevated = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
              ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($isElevated) {
    $guarded = Remove-MedProAppx -Pattern $critical -KeepList $keepList
    Assert-MedProTest "removal of keep-listed packages is refused" (
        $guarded.Removed -eq 0 -and $guarded.Failed -eq 0 -and $guarded.Blocked -gt 0)

    $noMatch = Remove-MedProAppx -Pattern @("MedPro.DefinitelyNotAPackage.*") -KeepList $keepList
    Assert-MedProTest "a pattern matching nothing is a no-op" (
        $noMatch.Removed -eq 0 -and $noMatch.Blocked -eq 0 -and $noMatch.Failed -eq 0)
} else {
    Write-Host "  SKIP  keep-list removal tests - run this session elevated to include them" -ForegroundColor Yellow
}

# A group listing a package the keep-list protects is a config contradiction:
# it reads as "remove this" but can never do so.
$contradictions = @()
foreach ($property in $sync.configs.debloat.groups.PSObject.Properties) {
    foreach ($pattern in @($property.Value.packages)) {
        if ($keepList -contains $pattern) { $contradictions += "$($property.Name) -> $pattern" }
    }
}
Assert-MedProTest "no debloat group lists a keep-listed package" ($contradictions.Count -eq 0)
if ($contradictions.Count) { $contradictions | ForEach-Object { Write-Host "        $_" -ForegroundColor Red } }

# --- Install sources ---------------------------------------------------------
# Get-MedProShareFile is exercised against a real local file. The copy path is
# identical for a UNC source, so this covers the logic without needing the share.
$sourceFile = Join-Path $env:TEMP "MedProSelfTestInstaller.exe"
[System.IO.File]::WriteAllBytes($sourceFile, (New-Object byte[] 4096))

$copied = Get-MedProShareFile -Path $sourceFile -FileName "SelfTestCopy.exe"
Assert-MedProTest "a share file is copied into the cache" (
    $copied -and (Test-Path -LiteralPath $copied) -and
    (Get-Item -LiteralPath $copied).Length -eq (Get-Item -LiteralPath $sourceFile).Length)

$missing = Get-MedProShareFile -Path "\\med-nonexistent-host\Install\nothing.exe" -FileName "SelfTestMissing.exe"
Assert-MedProTest "an unreachable share returns null instead of throwing" ($null -eq $missing)

# Non-UNC paths must not trigger a credential prompt, or a run with only vendor
# downloads would sit waiting on a dialog nobody expected.
$noShares = Connect-MedProShare -Path @("C:\Local\thing.exe", "")
Assert-MedProTest "local paths need no share connection" ($noShares.Count -eq 0)

if ($copied) { Remove-Item -LiteralPath $copied -Force -ErrorAction SilentlyContinue }
Remove-Item -LiteralPath $sourceFile -Force -ErrorAction SilentlyContinue

# --- Catalog sanity ----------------------------------------------------------
$sync.configs.applications = Get-Content "$repo\config\applications.json" -Raw | ConvertFrom-Json

$sourceless = @()
$typeless   = @()
foreach ($property in $sync.configs.applications.PSObject.Properties) {
    $app = $property.Value
    if (-not $app.path -and -not $app.url -and -not $app.winget) { $sourceless += $property.Name }
    if (($app.path -or $app.url) -and -not $app.type)            { $typeless   += $property.Name }
}
Assert-MedProTest "every application has an install source" ($sourceless.Count -eq 0)
Assert-MedProTest "every file-based application declares a type" ($typeless.Count -eq 0)

# Presets naming a key that no longer exists would silently under-provision.
$sync.configs.preset = Get-Content "$repo\config\preset.json" -Raw | ConvertFrom-Json
$appNames = $sync.configs.applications.PSObject.Properties.Name
$dangling = @()
foreach ($property in $sync.configs.preset.PSObject.Properties) {
    foreach ($key in @($property.Value.applications)) {
        if ($appNames -notcontains $key) { $dangling += "$($property.Name) -> $key" }
    }
}
Assert-MedProTest "every preset application reference resolves" ($dangling.Count -eq 0)
if ($dangling.Count) { $dangling | ForEach-Object { Write-Host "        $_" -ForegroundColor Red } }

# --- Rename validation -------------------------------------------------------
# Only the rejection paths and the same-name no-op are exercised. Passing a
# valid new name here would actually rename the machine running the test.
$sync.configs.provisioning = Get-Content "$repo\config\provisioning.json" -Raw | ConvertFrom-Json

Assert-MedProTest "a 16-character name is rejected" (
    -not (Rename-MedProComputer -NewName "ABCDEFGHIJKLMNOP").Success)
Assert-MedProTest "illegal characters are rejected" (
    -not (Rename-MedProComputer -NewName "MED_PRO!PC").Success)
Assert-MedProTest "an all-digit name is rejected" (
    -not (Rename-MedProComputer -NewName "12345").Success)
Assert-MedProTest "an empty name is rejected" (
    -not (Rename-MedProComputer -NewName "   ").Success)
Assert-MedProTest "the machine's current name is a no-op, not an error" (
    (Rename-MedProComputer -NewName $env:COMPUTERNAME).Success -and
    -not (Rename-MedProComputer -NewName $env:COMPUTERNAME).RebootRequired)

# No naming pattern is enforced any more, so an arbitrary valid name must pass
# validation. Checked without renaming by confirming it is not rejected for
# pattern reasons - only Windows' own rules should ever reject a name.
$arbitrary = "WHATEVER-01"
Assert-MedProTest "no MedPro naming pattern is enforced" (
    $arbitrary.Length -le 15 -and $arbitrary -notmatch '[^a-zA-Z0-9\-]' -and
    $null -eq $sync.configs.provisioning.naming)

Assert-MedProTest "the domain is configured for medpro.local" (
    $sync.configs.provisioning.domain.configured -eq $true -and
    $sync.configs.provisioning.domain.name -eq "medpro.local" -and
    $sync.configs.provisioning.domain.ouPath -like "OU=MedPro Computers*")

Remove-Item $testKey -Recurse -Force
if (Test-Path $sync.cachePath) { Remove-Item $sync.cachePath -Recurse -Force -ErrorAction SilentlyContinue }

Write-Host ""
Write-Host "$script:passed passed, $script:failed failed" -ForegroundColor $(if ($script:failed) { "Red" } else { "Green" })
if ($script:failed) { exit 1 }
