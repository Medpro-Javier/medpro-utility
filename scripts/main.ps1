# ---------------------------------------------------------------------------
# Builds the window and hands control to WPF.
#
# Two conventions do all the wiring here:
#   1. Every named XAML control is copied into $sync under its own name, so any
#      function in any runspace can reach it.
#   2. A control named "MedProFooButton" is bound to the function
#      "Invoke-MedProFooButton" if that function exists. No event table to
#      maintain, and a handler that does not exist yet is simply inert.
# ---------------------------------------------------------------------------

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Windows.Forms

# --- Load the layout ---------------------------------------------------------
try {
    [xml]$xamlDocument = $sync.xamlText
    $reader = New-Object System.Xml.XmlNodeReader $xamlDocument
    $sync.Form = [Windows.Markup.XamlReader]::Load($reader)
} catch {
    Write-Host "  Failed to build the interface: $($_.Exception.Message)" -ForegroundColor Red
    if ($sync.transcriptRunning) { Stop-Transcript | Out-Null }
    return
}

# --- Publish every named control into $sync ----------------------------------
$xamlNamespace   = "http://schemas.microsoft.com/winfx/2006/xaml"
$sync.ControlNames = New-Object System.Collections.Generic.List[string]

foreach ($node in $xamlDocument.SelectNodes("//*[@*[local-name()='Name']]")) {
    $controlName = $node.GetAttribute("Name")
    if ([string]::IsNullOrWhiteSpace($controlName)) {
        $controlName = $node.GetAttribute("Name", $xamlNamespace)
    }
    if ([string]::IsNullOrWhiteSpace($controlName)) { continue }

    $control = $sync.Form.FindName($controlName)
    if ($null -eq $control) { continue }

    $sync[$controlName] = $control
    $sync.ControlNames.Add($controlName)
}

# --- Bind buttons to their handlers by name ----------------------------------
$boundCount = 0
foreach ($controlName in $sync.ControlNames) {
    $control = $sync[$controlName]

    # CheckBox and RadioButton also derive from ButtonBase. They fall through
    # harmlessly because no Invoke-<name> function exists for a tweak checkbox.
    if ($control -isnot [System.Windows.Controls.Primitives.ButtonBase]) { continue }

    $handlerName = "Invoke-$controlName"
    if (-not (Get-Command -Name $handlerName -CommandType Function -ErrorAction SilentlyContinue)) { continue }

    # Created from a string so each handler binds to its own name rather than
    # capturing the loop variable, which would leave every button calling the last one.
    $control.Add_Click([scriptblock]::Create($handlerName))
    $boundCount++
}

Write-Host "  Interface ready - $($sync.ControlNames.Count) controls, $boundCount handlers bound." -ForegroundColor DarkGray

# --- Window chrome -----------------------------------------------------------
if ($sync.MedProVersionLabel) {
    $sync.MedProVersionLabel.Text = "v$($sync.version)"
}

Write-MedProLog "MedPro Utility $($sync.version) ready."
Write-MedProLog "Log file: $($sync.logFile)"

# --- Populate the data-driven tabs -------------------------------------------
# The XAML ships empty containers; the contents come from config/*.json so that
# adding a tweak or an application never means touching the layout.
Add-MedProBrandAssets
Add-MedProInstallControls
Add-MedProTweakControls
Add-MedProDebloatControls
Add-MedProProvisioningControls
Add-MedProPresetControls

# --- Fit the window to the screen it is actually on --------------------------
# The layout is sized so every tab fits without scrolling, but a provisioning
# tool gets run on whatever machine is being built - including 1366x768 laptops
# where the default size would open partly off-screen. Shrink to the working
# area rather than overflow it; the tabs fall back to scrolling, which is what
# the ScrollViewers are there for.
try {
    $workingArea = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea
    $maxWidth    = $workingArea.Width  - 40
    $maxHeight   = $workingArea.Height - 40

    if ($sync.Form.Width  -gt $maxWidth)  { $sync.Form.Width  = [Math]::Max($sync.Form.MinWidth,  $maxWidth) }
    if ($sync.Form.Height -gt $maxHeight) { $sync.Form.Height = [Math]::Max($sync.Form.MinHeight, $maxHeight) }
} catch {
    # No screen metrics available. The default size still opens, it just may
    # need moving on a small display.
}

# --- Shutdown ----------------------------------------------------------------
$sync.Form.Add_Closing({
    param($eventSender, $eventArgs)

    if ($sync.ProcessRunning) {
        $answer = [System.Windows.MessageBox]::Show(
            "A task is still running. Closing now could leave this machine half-configured.`n`nClose anyway?",
            "MedPro Utility",
            [System.Windows.MessageBoxButton]::YesNo,
            [System.Windows.MessageBoxImage]::Warning)

        if ($answer -ne [System.Windows.MessageBoxResult]::Yes) {
            $eventArgs.Cancel = $true
            return
        }
    }

    if ($sync.Runspace) {
        try { $sync.Runspace.Close(); $sync.Runspace.Dispose() } catch { }
    }

    # Any share mapped for this session goes away with it, so the technician's
    # credentials do not stay attached to the machine after the tool closes.
    foreach ($drive in @($sync.MappedShares)) {
        try { Remove-PSDrive -Name $drive -Force -ErrorAction SilentlyContinue } catch { }
    }
})

# --- Show --------------------------------------------------------------------
try {
    $sync.Form.ShowDialog() | Out-Null
} finally {
    if ($sync.transcriptRunning) {
        try { Stop-Transcript | Out-Null } catch { }
    }
    Write-Host "  Session log saved to $($sync.logFile)" -ForegroundColor DarkGray
}
