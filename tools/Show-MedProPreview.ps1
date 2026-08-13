<#
.SYNOPSIS
    Renders a tab of the MedPro Utility interface to a PNG.

.DESCRIPTION
    Builds the window exactly as the tool does at startup - loading the XAML,
    populating $sync, and running the control generators against the real
    config files - then renders it offscreen to an image.

    Nothing is applied to the machine and no elevation is needed, so this is the
    fast way to check a layout or config change without spinning up a VM.

    Must run under Windows PowerShell with -STA. WPF will not create a window
    on an MTA thread, which is pwsh's default.

.PARAMETER Tab
    Which tab to show: Install, Tweaks, Debloat, Provisioning, or About.

.PARAMETER OutputPath
    Where to write the PNG. Defaults to preview-<tab>.png beside this script.

.PARAMETER Height
    Render height. Raise it to capture a long tab in one image.

.PARAMETER Width
    Render width. Defaults to the window's own default width, which is the size
    the layout is tuned for; drop it to check how the tabs reflow when a
    technician runs the tool on a smaller display.

.EXAMPLE
    powershell.exe -STA -File .\tools\Show-MedProPreview.ps1 -Tab Debloat
#>
[CmdletBinding()]
param(
    [ValidateSet("Install", "Tweaks", "Debloat", "Provisioning", "About")]
    [string]$Tab = "Tweaks",

    [string]$OutputPath,

    [int]$Height = 0,

    [int]$Width = 0
)

$ErrorActionPreference = "Stop"

if ([System.Threading.Thread]::CurrentThread.GetApartmentState() -ne [System.Threading.ApartmentState]::STA) {
    throw "Run this with: powershell.exe -STA -File .\tools\Show-MedProPreview.ps1 -Tab $Tab"
}

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

$repo = Split-Path $PSScriptRoot -Parent
if (-not $OutputPath) { $OutputPath = Join-Path $PSScriptRoot "preview-$($Tab.ToLower()).png" }

# --- Stand up the same state the compiled script builds ----------------------
$global:sync = [Hashtable]::Synchronized(@{})
$sync.version = "preview"
$sync.logPath = "$env:ProgramData\MedProUtility\logs"
$sync.configs = @{}

foreach ($file in Get-ChildItem "$repo\config" -Filter *.json) {
    $sync.configs[$file.BaseName] = Get-Content $file.FullName -Raw | ConvertFrom-Json
}
foreach ($file in Get-ChildItem "$repo\functions" -Filter *.ps1 -Recurse) { . $file.FullName }

[xml]$document = Get-Content "$repo\xaml\inputXML.xaml" -Raw
$reader = New-Object System.Xml.XmlNodeReader $document
$window = [Windows.Markup.XamlReader]::Load($reader)
$sync.Form = $window

$xamlNamespace = "http://schemas.microsoft.com/winfx/2006/xaml"
foreach ($node in $document.SelectNodes("//*[@*[local-name()='Name']]")) {
    $name = $node.GetAttribute("Name")
    if (-not $name) { $name = $node.GetAttribute("Name", $xamlNamespace) }
    if (-not $name) { continue }
    $control = $window.FindName($name)
    if ($control) { $sync[$name] = $control }
}

foreach ($generator in @("Add-MedProBrandAssets", "Add-MedProInstallControls", "Add-MedProTweakControls",
                         "Add-MedProDebloatControls", "Add-MedProProvisioningControls", "Add-MedProPresetControls")) {
    if (Get-Command $generator -ErrorAction SilentlyContinue) { & $generator }
}

# Run the first preset so the image shows a realistic selected state across
# every tab rather than an empty one.
if ($sync.MedProPresetCombo -and $sync.MedProPresetCombo.Items.Count -gt 0) {
    $sync.MedProPresetCombo.SelectedIndex = 0
    Invoke-MedProApplyPresetButton
}

$tabIndex = @{ Install = 0; Tweaks = 1; Debloat = 2; Provisioning = 3; About = 4 }[$Tab]
$sync.MedProTabControl.SelectedIndex = $tabIndex

# --- Render ------------------------------------------------------------------
# Implicit styles resolve by walking up to Window.Resources, so the dictionary
# has to come with the content when it is reparented out of the Window.
# Default to the real window size so the preview answers the question that
# actually matters: does this tab fit without a scrollbar as shipped?
if ($Width  -le 0) { $Width  = [int]$window.Width }
if ($Height -le 0) { $Height = [int]$window.Height }

$width = $Width
$root  = $window.Content
$window.Content = $null

$surface = New-Object System.Windows.Controls.Border
$surface.Resources  = $window.Resources
$surface.Width      = $width
$surface.Height     = $Height
$surface.Background = New-Object System.Windows.Media.SolidColorBrush(
    [System.Windows.Media.ColorConverter]::ConvertFromString("#fbf9fc"))
$surface.Child = $root

$surface.Measure((New-Object System.Windows.Size($width, $Height)))
$surface.Arrange((New-Object System.Windows.Rect(0, 0, $width, $Height)))
$surface.UpdateLayout()

$bitmap = New-Object System.Windows.Media.Imaging.RenderTargetBitmap(
    $width, $Height, 96, 96, [System.Windows.Media.PixelFormats]::Pbgra32)
$bitmap.Render($surface)

$encoder = New-Object System.Windows.Media.Imaging.PngBitmapEncoder
$encoder.Frames.Add([System.Windows.Media.Imaging.BitmapFrame]::Create($bitmap))
$stream = [System.IO.File]::Create($OutputPath)
$encoder.Save($stream)
$stream.Close()

Write-Host "Rendered the $Tab tab to $OutputPath" -ForegroundColor Green
