# MedPro Utility

Internal Windows 11 provisioning, optimization, and debloat tool for
MedPro Healthcare Staffing IT.

One command on a freshly imaged machine installs the MedPro software suite,
applies the standard performance and privacy tweaks, strips Windows consumer
bloatware, and runs first-boot provisioning — the same way every time, with a
full transcript of everything it touched.

## Running it

Open **PowerShell as Administrator** and run:

```bash
irm https://raw.githubusercontent.com/MedProStaffing/medpro-utility/main/medproutil.ps1 | iex
```

The tool relaunches itself elevated if it needs to. Windows 11 only —
it refuses to run on anything older, because every tweak in it was written
against Windows 11 registry paths.

## Building from source

```bash
.\Compile.ps1
```

`Compile.ps1` folds every function, config file, and the WPF layout into a
single `medproutil.ps1`. That one file is the entire distributable. Use
`-Run` to launch it immediately after a successful build.

The build fails rather than producing a broken script if any config is invalid
JSON, the XAML is malformed, or the generated PowerShell does not parse.

## Before first use

The catalog and the domain are configured for MedPro. Two things still need
confirming on a test machine:

- **The silent-install switches for Ricoh Printers and the Kaseya Agent are
  assumptions.** Both use `/S`, which is the common convention but has not been
  verified against those specific installers. Run each once on a VM; if one shows
  UI, capture the right switch and update `args` in `config/applications.json`.
- **Microsoft 365 does not install silently.** The supplied `OfficeSetup.exe` is
  the Click-to-Run bootstrapper, which has no supported quiet switch. It is
  marked `"interactive": true` so the tool warns before a run starts, but a
  technician has to stay at the machine. To make it unattended, replace that
  entry with the Office Deployment Tool and a MedPro configuration XML.

## Tabs

| Tab | What it does |
|---|---|
| **Install** | Installs the MedPro app suite from vendor links, falling back to winget |
| **Tweaks** | 44 reversible performance, privacy, and interface settings |
| **Debloat** | Removes Windows consumer apps, guarded by a keep-list |
| **Provisioning** | Rename, domain join, power profile and screen lock |
| **About** | Credits, safety notes, and a shortcut to the session log |

The **preset** dropdown in the header ticks the right boxes across Install,
Tweaks, and Debloat in one go — Standard workstation, IT technician, Laptop, or
Privacy only. A preset only *selects*; the technician still reviews each tab and
presses its own button. Presets live in `config/preset.json`.

## Repository layout

| Path | What lives there |
|---|---|
| `Compile.ps1` | Build script — source in, single file out |
| `medproutil.ps1` | Generated output. **Do not edit**; it is overwritten on every build |
| `config/*.json` | Everything data-driven: apps, tweaks, debloat lists, provisioning, presets |
| `functions/private/` | Helpers — `Get-MedPro*`, `Set-MedPro*`, `Install-MedPro*` |
| `functions/public/` | UI handlers — `Invoke-MedPro*` |
| `scripts/start.ps1` | Startup gates: Windows 11, elevation, STA, logging |
| `scripts/main.ps1` | Builds the window and wires up the handlers |
| `xaml/inputXML.xaml` | WPF layout and the MedPro design system — palette, type, shape, motion |
| `assets/*.png` | Official brand artwork, base64-embedded into the build by `Compile.ps1` |
| `tools/` | Development helpers — see below |

## Branding

The interface follows the MedPro Healthcare Staffing design system: MedPro Purple
anchors it, Coral is the call to action, Teal marks focus and the active tab, and
Lavender is held in reserve. Cards are white with a hairline border and a soft
plum-tinted lift; every button is a halfpipe. Type is Sofia Pro, falling back to
Poppins and then Segoe UI.

Two things are worth pushing to workstations to get the intended result:

- **Sofia Pro** (Adobe Fonts kit) or, failing that, **Poppins** (free, Google
  Fonts). Neither ships with Windows, so an un-provisioned machine renders the
  interface in Segoe UI. Nothing breaks — it just isn't the brand face.
- The logo is embedded in the build, so it needs nothing installed.

Sizes sit at the lower end of the brand type scale on purpose: this is a dense
technician tool and every tab is meant to fit on one screen without scrolling.
The weights, casing, colour roles, and shapes are the system's exactly.

## Development tools

```bash
powershell.exe -NoProfile -File .\tools\Test-MedProEngine.ps1
```

Self-test for the tweak engine and the debloat keep-list. Runs against a scratch
registry key, touches nothing real, needs no VM. Run it after changing anything
under `functions/private`. Run it **elevated** to include the keep-list removal
checks, which need `Get-AppxPackage -AllUsers`.

```bash
powershell.exe -NoProfile -STA -File .\tools\Show-MedProPreview.ps1 -Tab Debloat
```

Renders a tab to a PNG without launching the tool or touching the machine. The
fastest way to check a layout or config change.

### Two conventions worth knowing

**Function files must contain the string `MedPro`** or `Compile.ps1` silently
leaves them out of the build. It prints a warning when it skips one.

**Buttons bind to handlers by name.** A control named `MedProInstallButton`
is automatically wired to a function called `Invoke-MedProInstallButton`. There
is no event table to keep in sync — add the control, add the function, done.

## Adding an application

Add an entry to `config/applications.json` and rebuild. No PowerShell required.

An app can come from three sources, tried in order: **`path`** (a UNC share or
local file), then **`url`** (a vendor download), then **`winget`**. An entry needs
at least one; the build fails if it has none.

```json
"MedProInstallChrome": {
  "content":     "Google Chrome",
  "category":    "MedPro Standard Build",
  "description": "Google Chrome, enterprise MSI",
  "url":         "https://dl.google.com/.../googlechromestandaloneenterprise64.msi",
  "type":        "msi",
  "args":        "/qn /norestart",
  "winget":      "Google.Chrome",
  "detect":      "%ProgramFiles%\\Google\\Chrome\\Application\\chrome.exe",
  "standard":    true
}
```

For software on `\\med-dc-01\Install`, use `path` instead of `url`. Note the
doubled backslashes — JSON requires them:

```json
"MedProInstallKaseyaAgent": {
  "content": "Kaseya Agent",
  "category": "MedPro Standard Build",
  "path": "\\\\med-dc-01\\Install\\KASEYA INSTALLER FOR MEDPRO\\Kaseya_Medpro_Workstations_VSA08.exe",
  "type": "exe",
  "args": "/S",
  "standard": true
}
```

Share files are copied to the local cache before running, rather than executed
over SMB — a 284 MB installer streamed off a flaky link fails in confusing ways.
If the share refuses the machine, the tool prompts the technician for credentials
once per share, before the install run starts. Those credentials are used for the
session and are never written to disk.

| Field | What it does |
|---|---|
| `type` | `msi`, `exe`, `msix`, `appx`, or `msixbundle`. Required with `path` or `url` |
| `args` | Silent switches. Defaults to `/qn /norestart` for MSI, `/S` for EXE |
| `detect` | File or registry path. If present, the app is skipped as already installed |
| `standard` | `true` puts it in the MedPro standard build |
| `interactive` | `true` if the installer cannot run silently — the tool warns up front |
| `sha256` | Optional. Verified after download; a mismatch fails the source |

## Adding a tweak

Add an entry to `config/tweaks.json` and rebuild.

**Every tweak must be reversible.** Give each registry value an `OriginalValue`,
or supply an `UndoScript` that puts the machine back. A tweak that cannot be
undone does not belong in this tool.

## Safety

- A **system restore point** is created before any tweak batch is applied.
- **Every tweak is reversible** via `OriginalValue` or an `UndoScript`.
- **Debloat is governed by a keep-list** in `config/debloat.json`, so
  business-critical packages are never removed.
- **Every session is transcribed** to `%ProgramData%\MedProUtility\logs`.
- **No credentials are stored.** Domain join prompts the technician at run time;
  nothing is written to the repo, the config, or the log.

Test changes on a **VM with a snapshot**, never on a working machine.

## Credits

Architecture and a substantial portion of the tweak definitions are derived from
[WinUtil](https://github.com/ChrisTitusTech/winutil) by Chris Titus Tech, used
under the MIT License. See [NOTICE.md](NOTICE.md).

MIT Licensed. Copyright (c) 2026 MedPro Healthcare Staffing.
