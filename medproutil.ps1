<#
================================================================================
  MedPro Utility 1.0.0
  Windows 11 provisioning, optimization, and debloat tool.

  GENERATED FILE - DO NOT EDIT.
  Edit the sources under config/, functions/, scripts/, and xaml/, then run
  .\Compile.ps1 to regenerate this file.

  Copyright (c) 2026 MedPro Healthcare Staffing. MIT Licensed.
  Portions derived from WinUtil by Chris Titus Tech (MIT). See NOTICE.md.
================================================================================
#>

$sync = [Hashtable]::Synchronized(@{})
$sync.version   = "1.0.0"
$sync.launchUrl = "https://raw.githubusercontent.com/MedProStaffing/medpro-utility/main/medproutil.ps1"
$sync.logPath   = "$env:ProgramData\MedProUtility\logs"
$sync.cachePath = "$env:ProgramData\MedProUtility\cache"
$sync.configs   = @{}
$sync.assets    = @{}
$sync.ProcessRunning = $false
#region Brand assets
$sync.assets.logoMedpro = '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'
#endregion

#region Configuration
$sync.configs.applications = @'
{
  "MedProInstallChrome": {
    "content": "Google Chrome",
    "category": "MedPro Standard Build",
    "categoryNote": "The software every MedPro workstation gets. Sources come from MedProUtil_Software.xlsx.",
    "description": "Google Chrome, enterprise MSI. Installs machine-wide for every user on the PC.",
    "url": "https://dl.google.com/dl/chrome/install/googlechromestandaloneenterprise64.msi",
    "type": "msi",
    "args": "/qn /norestart",
    "winget": "Google.Chrome",
    "detect": "%ProgramFiles%\\Google\\Chrome\\Application\\chrome.exe",
    "standard": true
  },

  "MedProInstallOffice": {
    "content": "Microsoft Office 365",
    "category": "MedPro Standard Build",
    "description": "Microsoft 365 Apps via the Click-to-Run bootstrapper. This installer does NOT run silently - it shows Microsoft's own installer UI and a technician has to stay at the machine. To make it unattended, switch this entry to the Office Deployment Tool with a MedPro configuration XML.",
    "url": "https://go.microsoft.com/fwlink/?linkid=2264705&clcid=0x409&culture=en-us&country=us",
    "type": "exe",
    "args": "",
    "interactive": true,
    "detect": "%ProgramFiles%\\Microsoft Office\\root\\Office16\\WINWORD.EXE",
    "standard": true
  },

  "MedProInstallTeams": {
    "content": "Microsoft Teams",
    "category": "MedPro Standard Build",
    "description": "New Teams, provisioned machine-wide with teamsbootstrapper.exe -p so every user profile gets it. Microsoft's supported deployment method; it fetches the current version itself, so this link does not go stale.",
    "url": "https://go.microsoft.com/fwlink/?linkid=2243204",
    "type": "exe",
    "args": "-p",
    "standard": true
  },

  "MedProInstallRingCentral": {
    "content": "RingCentral",
    "category": "MedPro Standard Build",
    "description": "RingCentral desktop app for MedPro phone and messaging. Large download, around 415 MB.",
    "url": "https://app.ringcentral.com/download/squirrel-windows/RingCentral-Setup.msi",
    "type": "msi",
    "args": "/qn /norestart",
    "standard": true
  },

  "MedProInstallRicohPrinters": {
    "content": "Ricoh Printers",
    "category": "MedPro Standard Build",
    "description": "All MedPro Ricoh printer drivers and queues, from \\\\med-dc-01\\Install. Around 284 MB, copied locally before running. Needs network access to the share.",
    "path": "\\\\med-dc-01\\Install\\Ricoh\\All_Ricoh_Printers.exe",
    "type": "exe",
    "args": "/S",
    "standard": true
  },

  "MedProInstallKaseyaAgent": {
    "content": "Kaseya Agent",
    "category": "MedPro Standard Build",
    "description": "Kaseya VSA management agent for MedPro workstations, from \\\\med-dc-01\\Install. Install this on every machine - it is how IT manages the PC afterwards.",
    "path": "\\\\med-dc-01\\Install\\KASEYA INSTALLER FOR MEDPRO\\Kaseya_Medpro_Workstations_VSA08.exe",
    "type": "exe",
    "args": "/S",
    "standard": true
  },

  "MedProInstall7Zip": {
    "content": "7-Zip",
    "category": "IT Technician Tools",
    "categoryNote": "Not part of the standard build. These are for MedPro IT machines and are only selected by the IT technician preset.",
    "description": "Archive tool. The direct link is version-pinned, so it falls back to winget once 7-Zip publishes a newer build.",
    "url": "https://www.7-zip.org/a/7z2408-x64.exe",
    "type": "exe",
    "args": "/S",
    "winget": "7zip.7zip",
    "detect": "%ProgramFiles%\\7-Zip\\7z.exe"
  },

  "MedProInstallNotepadPlusPlus": {
    "content": "Notepad++",
    "category": "IT Technician Tools",
    "description": "Text editor for logs, CSVs, and config files.",
    "winget": "Notepad++.Notepad++",
    "detect": "%ProgramFiles%\\Notepad++\\notepad++.exe"
  },

  "MedProInstallPowerToys": {
    "content": "Microsoft PowerToys",
    "category": "IT Technician Tools",
    "description": "FancyZones, PowerRename, and Text Extractor.",
    "winget": "Microsoft.PowerToys"
  },

  "MedProInstallVSCode": {
    "content": "Visual Studio Code",
    "category": "IT Technician Tools",
    "description": "Editor for scripts and configuration.",
    "winget": "Microsoft.VisualStudioCode"
  }
}
'@ | ConvertFrom-Json

$sync.configs.debloat = @'
{
  "keepList": [
    "Microsoft.DesktopAppInstaller",
    "Microsoft.WindowsStore",
    "Microsoft.StorePurchaseApp",
    "Microsoft.SecHealthUI",
    "Microsoft.WindowsTerminal",
    "Microsoft.WindowsNotepad",
    "Microsoft.Paint",
    "Microsoft.ScreenSketch",
    "Microsoft.WindowsCalculator",
    "Microsoft.WindowsCamera",
    "Microsoft.Windows.Photos",
    "Microsoft.MicrosoftStickyNotes",
    "Microsoft.CompanyPortal",
    "MicrosoftCorporationII.QuickAssist",
    "Microsoft.RemoteDesktop",
    "MSTeams",
    "Microsoft.Office.*",
    "Microsoft.OneDriveSync",
    "Microsoft.UI.Xaml.*",
    "Microsoft.VCLibs.*",
    "Microsoft.NET.Native.*",
    "Microsoft.Services.Store.Engagement",
    "Microsoft.WindowsAppRuntime.*",
    "Microsoft.WebpImageExtension",
    "Microsoft.HEIFImageExtension",
    "Microsoft.RawImageExtension",
    "Microsoft.AV1VideoExtension",
    "Microsoft.HEVCVideoExtension",
    "Microsoft.VP9VideoExtensions",
    "Microsoft.WebMediaExtensions",
    "Microsoft.MicrosoftEdge.*",
    "Microsoft.Winget.*",
    "Windows.*",
    "MicrosoftWindows.Client.CBS",
    "MicrosoftWindows.Client.Core",
    "MicrosoftWindows.Client.FileExp",
    "MicrosoftWindows.UndockedDevKit",
    "Microsoft.AAD.BrokerPlugin",
    "Microsoft.AccountsControl",
    "Microsoft.CredDialogHost",
    "Microsoft.ECApp",
    "Microsoft.LockApp",
    "Microsoft.Windows.CloudExperienceHost",
    "Microsoft.Windows.ContentDeliveryManager",
    "Microsoft.Windows.ShellExperienceHost",
    "Microsoft.Windows.StartMenuExperienceHost",
    "Microsoft.Windows.SecureAssessmentBrowser",
    "Microsoft.Windows.PeopleExperienceHost",
    "Microsoft.Windows.Search",
    "Microsoft.XboxGameCallableUI"
  ],

  "groups": {
    "MedProDebloatXbox": {
      "content": "Xbox and gaming",
      "description": "Xbox Console Companion, Game Bar, Game Speech Window, and the Xbox Game Overlay. None of these have a role on a staffing workstation.",
      "category": "Consumer apps",
      "categoryNote": "Removes the app for every user on this machine and deprovisions it so new profiles do not get it either.",
      "recommended": true,
      "packages": [
        "Microsoft.XboxApp",
        "Microsoft.XboxGameOverlay",
        "Microsoft.XboxGamingOverlay",
        "Microsoft.XboxIdentityProvider",
        "Microsoft.XboxSpeechToTextOverlay",
        "Microsoft.Xbox.TCUI",
        "Microsoft.GamingApp",
        "Microsoft.GamingServices"
      ]
    },

    "MedProDebloatGames": {
      "content": "Bundled games",
      "description": "Microsoft Solitaire Collection, Mahjong, Bubble Witch, and the other titles Windows installs on first sign-in.",
      "category": "Consumer apps",
      "recommended": true,
      "packages": [
        "Microsoft.MicrosoftSolitaireCollection",
        "Microsoft.MinecraftUWP",
        "king.com.*",
        "*CandyCrush*",
        "*BubbleWitch*",
        "*Royal Revolt*",
        "*Dolby*",
        "*Disney*",
        "*Spotify*",
        "*Twitter*",
        "*TikTok*",
        "*Facebook*",
        "*Instagram*",
        "*LinkedInforWindows*"
      ]
    },

    "MedProDebloatBing": {
      "content": "Bing news, weather, and finance",
      "description": "The Bing-backed News, Weather, Finance, and Sports apps and their live tiles.",
      "category": "Consumer apps",
      "recommended": true,
      "packages": [
        "Microsoft.BingNews",
        "Microsoft.BingWeather",
        "Microsoft.BingFinance",
        "Microsoft.BingSports",
        "Microsoft.BingSearch",
        "Microsoft.BingTravel",
        "Microsoft.BingHealthAndFitness",
        "Microsoft.BingFoodAndDrink"
      ]
    },

    "MedProDebloatSocial": {
      "content": "Skype, Phone Link, and consumer Teams",
      "description": "Consumer communication apps. Does not touch the work version of Teams, which is kept.",
      "category": "Consumer apps",
      "recommended": true,
      "packages": [
        "Microsoft.SkypeApp",
        "Microsoft.YourPhone",
        "Microsoft.People",
        "MicrosoftTeams",
        "Microsoft.Messaging",
        "Microsoft.OneConnect"
      ]
    },

    "MedProDebloatMedia": {
      "content": "Clipchamp, Media Player, and Movies",
      "description": "Clipchamp video editor, the Groove-derived Media Player, and Films and TV. Remove unless a MedPro role needs video editing on the machine.",
      "category": "Consumer apps",
      "recommended": true,
      "packages": [
        "Clipchamp.Clipchamp",
        "Microsoft.ZuneMusic",
        "Microsoft.ZuneVideo"
      ]
    },

    "MedProDebloatMisc": {
      "content": "Tips, Maps, Feedback Hub, and 3D apps",
      "description": "Get Started, Get Help, Maps, Feedback Hub, Alarms and Clock, To Do, Mixed Reality Portal, 3D Builder, and Print 3D.",
      "category": "Consumer apps",
      "recommended": true,
      "packages": [
        "Microsoft.Getstarted",
        "Microsoft.GetHelp",
        "Microsoft.WindowsMaps",
        "Microsoft.WindowsFeedbackHub",
        "Microsoft.WindowsAlarms",
        "Microsoft.Todos",
        "Microsoft.MixedReality.Portal",
        "Microsoft.3DBuilder",
        "Microsoft.Print3D",
        "Microsoft.Microsoft3DViewer",
        "Microsoft.WindowsSoundRecorder",
        "Microsoft.PowerAutomateDesktop",
        "Microsoft.Wallet",
        "Microsoft.WindowsPhone"
      ]
    },

    "MedProDebloatCopilot": {
      "content": "Copilot and Recall",
      "description": "Removes the Copilot app packages. Pair this with the Copilot and Recall tweak, which blocks them by policy so Windows cannot reinstall them.",
      "category": "AI and Widgets",
      "categoryNote": "Windows reinstalls some of these on feature updates. The matching policy tweaks on the Tweaks tab are what make the removal stick.",
      "recommended": true,
      "packages": [
        "Microsoft.Copilot",
        "Microsoft.Windows.Ai.Copilot.Provider",
        "MicrosoftWindows.Client.CoPilot",
        "Microsoft.MicrosoftOfficeHub"
      ]
    },

    "MedProDebloatWidgets": {
      "content": "Widgets board",
      "description": "The Windows Web Experience Pack that powers the Widgets panel. Pair with the Widgets tweak on the Tweaks tab.",
      "category": "AI and Widgets",
      "recommended": true,
      "packages": [
        "MicrosoftWindows.Client.WebExperience"
      ]
    },

    "MedProDebloatDevHome": {
      "content": "Dev Home and Outlook (new)",
      "description": "Dev Home and the new Outlook for Windows preview app. Leave Outlook alone if MedPro has moved staff to the new client.",
      "category": "AI and Widgets",
      "caution": true,
      "packages": [
        "Microsoft.Windows.DevHome",
        "Microsoft.OutlookForWindows"
      ]
    },

    "MedProDebloatOEM": {
      "content": "OEM manufacturer bloat",
      "description": "Consumer software Dell, HP, and Lenovo preinstall on business machines. Support and driver-update utilities are matched loosely, so check the log to confirm nothing MedPro relies on was removed.",
      "category": "Manufacturer",
      "categoryNote": "Only useful on a machine imaged from an OEM factory image. Harmless on a clean MedPro image, where none of these exist.",
      "caution": true,
      "packages": [
        "*McAfee*",
        "*Norton*",
        "*Booking.com*",
        "*Amazon.com.Amazon*",
        "*ACGMediaPlayer*",
        "*DellCustomerConnect*",
        "*DellDigitalDelivery*",
        "*DellSupportAssistforPCs*",
        "*HPJumpStart*",
        "*HPPCHardwareDiagnostics*",
        "*HPPowerManager*",
        "*HPPrivacySettings*",
        "*HPQuickDrop*",
        "*HPSupportAssistant*",
        "*HPSystemInformation*",
        "*LenovoCompanion*",
        "*LenovoSettings*",
        "*LenovoUtility*",
        "*E046963F.LenovoCompanion*"
      ]
    }
  }
}
'@ | ConvertFrom-Json

$sync.configs.preset = @'
{
  "MedProPresetStandard": {
    "content": "Standard workstation",
    "description": "The MedPro base build. Everything a staff machine gets: privacy and performance tweaks, the standard app suite, and consumer bloatware removed.",
    "tweaks": [
      "MedProTweaksTelemetry",
      "MedProTweaksActivity",
      "MedProTweaksConsumerFeatures",
      "MedProTweaksSuggestions",
      "MedProTweaksDeliveryOptimization",
      "MedProTweaksLocation",
      "MedProTweaksWidgets",
      "MedProTweaksCopilot",
      "MedProTweaksWPBT",
      "MedProTweaksDeviceMetadata",
      "MedProTweaksSyncNotifications",
      "MedProTweaksBackgroundApps",
      "MedProTweaksServices",
      "MedProTweaksEndTask",
      "MedProTweaksLongPaths",
      "MedProTweaksVerboseLogon",
      "MedProTweaksDetailedBSoD",
      "MedProTweaksShowFileExtensions",
      "MedProTweaksTaskbarLeft",
      "MedProTweaksSearchIconOnly",
      "MedProTweaksDisableBingSearch",
      "MedProTweaksStartRecommendations",
      "MedProTweaksClassicContextMenu",
      "MedProTweaksNumLock",
      "MedProTweaksStickyKeys"
    ],
    "applications": [
      "MedProInstallChrome",
      "MedProInstallOffice",
      "MedProInstallTeams",
      "MedProInstallRingCentral",
      "MedProInstallRicohPrinters",
      "MedProInstallKaseyaAgent"
    ],
    "debloat": [
      "MedProDebloatXbox",
      "MedProDebloatGames",
      "MedProDebloatBing",
      "MedProDebloatSocial",
      "MedProDebloatMedia",
      "MedProDebloatMisc",
      "MedProDebloatCopilot",
      "MedProDebloatWidgets"
    ]
  },

  "MedProPresetTechnician": {
    "content": "IT technician workstation",
    "description": "The standard build plus the tools MedPro IT needs: VS Code, PowerToys, Notepad++, 7-Zip, hidden files shown, and the unsigned RDP prompt suppressed.",
    "tweaks": [
      "MedProTweaksTelemetry",
      "MedProTweaksActivity",
      "MedProTweaksConsumerFeatures",
      "MedProTweaksSuggestions",
      "MedProTweaksDeliveryOptimization",
      "MedProTweaksWidgets",
      "MedProTweaksCopilot",
      "MedProTweaksWPBT",
      "MedProTweaksDeviceMetadata",
      "MedProTweaksSyncNotifications",
      "MedProTweaksBackgroundApps",
      "MedProTweaksServices",
      "MedProTweaksEndTask",
      "MedProTweaksLongPaths",
      "MedProTweaksVerboseLogon",
      "MedProTweaksDetailedBSoD",
      "MedProTweaksShowFileExtensions",
      "MedProTweaksShowHiddenFiles",
      "MedProTweaksTaskbarLeft",
      "MedProTweaksSearchIconOnly",
      "MedProTweaksDisableBingSearch",
      "MedProTweaksStartRecommendations",
      "MedProTweaksClassicContextMenu",
      "MedProTweaksNumLock",
      "MedProTweaksStickyKeys",
      "MedProTweaksUnsignedRdp"
    ],
    "applications": [
      "MedProInstallChrome",
      "MedProInstallOffice",
      "MedProInstallTeams",
      "MedProInstallRingCentral",
      "MedProInstallRicohPrinters",
      "MedProInstallKaseyaAgent",
      "MedProInstall7Zip",
      "MedProInstallNotepadPlusPlus",
      "MedProInstallPowerToys",
      "MedProInstallVSCode"
    ],
    "debloat": [
      "MedProDebloatXbox",
      "MedProDebloatGames",
      "MedProDebloatBing",
      "MedProDebloatSocial",
      "MedProDebloatMedia",
      "MedProDebloatMisc",
      "MedProDebloatCopilot",
      "MedProDebloatWidgets"
    ]
  },

  "MedProPresetPrivacyOnly": {
    "content": "Privacy only",
    "description": "Telemetry, tracking, and AI data collection off, and nothing else. For a machine already in service where removing apps or changing the interface would disrupt someone mid-shift.",
    "tweaks": [
      "MedProTweaksTelemetry",
      "MedProTweaksActivity",
      "MedProTweaksConsumerFeatures",
      "MedProTweaksSuggestions",
      "MedProTweaksDeliveryOptimization",
      "MedProTweaksLocation",
      "MedProTweaksCopilot",
      "MedProTweaksDeviceMetadata",
      "MedProTweaksSyncNotifications"
    ],
    "applications": [],
    "debloat": []
  },

  "MedProPresetLaptop": {
    "content": "Laptop",
    "description": "The standard build minus anything that hurts a portable machine. Hibernation and Fast Startup stay on, and the display and sleep timeouts are the ones a laptop needs.",
    "tweaks": [
      "MedProTweaksTelemetry",
      "MedProTweaksActivity",
      "MedProTweaksConsumerFeatures",
      "MedProTweaksSuggestions",
      "MedProTweaksDeliveryOptimization",
      "MedProTweaksLocation",
      "MedProTweaksWidgets",
      "MedProTweaksCopilot",
      "MedProTweaksWPBT",
      "MedProTweaksDeviceMetadata",
      "MedProTweaksSyncNotifications",
      "MedProTweaksBackgroundApps",
      "MedProTweaksServices",
      "MedProTweaksEndTask",
      "MedProTweaksLongPaths",
      "MedProTweaksVerboseLogon",
      "MedProTweaksDetailedBSoD",
      "MedProTweaksShowFileExtensions",
      "MedProTweaksTaskbarLeft",
      "MedProTweaksSearchIconOnly",
      "MedProTweaksDisableBingSearch",
      "MedProTweaksStartRecommendations",
      "MedProTweaksClassicContextMenu",
      "MedProTweaksStickyKeys"
    ],
    "applications": [
      "MedProInstallChrome",
      "MedProInstallOffice",
      "MedProInstallTeams",
      "MedProInstallRingCentral",
      "MedProInstallRicohPrinters",
      "MedProInstallKaseyaAgent"
    ],
    "debloat": [
      "MedProDebloatXbox",
      "MedProDebloatGames",
      "MedProDebloatBing",
      "MedProDebloatSocial",
      "MedProDebloatMedia",
      "MedProDebloatMisc",
      "MedProDebloatCopilot",
      "MedProDebloatWidgets"
    ]
  }
}
'@ | ConvertFrom-Json

$sync.configs.provisioning = @'
{
  "_comment": "MedPro site settings for the Provisioning tab. There is deliberately no naming standard here - the tab shows the machine's current name and lets a technician edit it, with only Windows' own rules enforced.",

  "domain": {
    "configured": true,
    "name": "medpro.local",
    "ouPath": "OU=MedPro Computers,DC=medpro,DC=local"
  },

  "power": {
    "planName": "Balanced",
    "planGuid": "381b4222-f694-41f0-9685-ff5bb260df2e",
    "monitorTimeoutAC": 15,
    "monitorTimeoutDC": 10,
    "standbyTimeoutAC": 60,
    "standbyTimeoutDC": 30,
    "hibernateTimeoutAC": 0,
    "hibernateTimeoutDC": 0,
    "lidActionAC": 0,
    "lidActionDC": 1,
    "screenLockMinutes": 15,
    "description": "Balanced plan, display off after 15 minutes on mains, sleep after an hour, laptop lid sleeps on battery only. The screen locks after 15 minutes and requires a password, which is the control that matters on a machine handling candidate and client records."
  }
}
'@ | ConvertFrom-Json

$sync.configs.tweaks = @'
{
  "MedProTweaksTelemetry": {
    "Content": "Telemetry - Disable",
    "Description": "Stops Windows sending diagnostic and usage data to Microsoft, turns off the advertising ID and tailored experiences, and disables the scheduled tasks that collect it.",
    "category": "Essential Tweaks",
    "categoryNote": "Applied to every MedPro workstation. All of these are safe on a domain-joined machine and fully reversible.",
    "recommended": true,
    "registry": [
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\DataCollection", "Name": "AllowTelemetry", "Type": "DWord", "Value": "0", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\DataCollection", "Name": "AllowTelemetry", "Type": "DWord", "Value": "0", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\CloudContent", "Name": "DisableTailoredExperiencesWithDiagnosticData", "Type": "DWord", "Value": "1", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\AdvertisingInfo", "Name": "Enabled", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Privacy", "Name": "TailoredExperiencesWithDiagnosticDataEnabled", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Speech_OneCore\\Settings\\OnlineSpeechPrivacy", "Name": "HasAccepted", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Input\\TIPC", "Name": "Enabled", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\InputPersonalization", "Name": "RestrictImplicitInkCollection", "Type": "DWord", "Value": "1", "OriginalValue": "0" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\InputPersonalization", "Name": "RestrictImplicitTextCollection", "Type": "DWord", "Value": "1", "OriginalValue": "0" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\InputPersonalization\\TrainedDataStore", "Name": "HarvestContacts", "Type": "DWord", "Value": "0", "OriginalValue": "1" }
    ],
    "service": [
      { "Name": "DiagTrack", "StartupType": "Disabled", "OriginalType": "Automatic" },
      { "Name": "dmwappushservice", "StartupType": "Disabled", "OriginalType": "Manual" }
    ],
    "InvokeScript": [
      "foreach ($taskName in @('Microsoft Compatibility Appraiser','ProgramDataUpdater','Consolidator','UsbCeip','DmClient','DmClientOnScenarioDownload')) { Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue | Disable-ScheduledTask -ErrorAction SilentlyContinue | Out-Null }"
    ],
    "UndoScript": [
      "foreach ($taskName in @('Microsoft Compatibility Appraiser','ProgramDataUpdater','Consolidator','UsbCeip','DmClient','DmClientOnScenarioDownload')) { Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue | Enable-ScheduledTask -ErrorAction SilentlyContinue | Out-Null }"
    ]
  },

  "MedProTweaksActivity": {
    "Content": "Activity History - Disable",
    "Description": "Stops Windows recording which apps and documents were opened and syncing that timeline to the Microsoft account.",
    "category": "Essential Tweaks",
    "recommended": true,
    "registry": [
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\System", "Name": "EnableActivityFeed", "Type": "DWord", "Value": "0", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\System", "Name": "PublishUserActivities", "Type": "DWord", "Value": "0", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\System", "Name": "UploadUserActivities", "Type": "DWord", "Value": "0", "OriginalValue": "<RemoveEntry>" }
    ]
  },

  "MedProTweaksConsumerFeatures": {
    "Content": "Consumer Features - Disable",
    "Description": "Blocks Windows from silently installing promoted consumer apps and games onto a new profile. This is the single most effective anti-bloat setting on a fresh image.",
    "category": "Essential Tweaks",
    "recommended": true,
    "registry": [
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\CloudContent", "Name": "DisableWindowsConsumerFeatures", "Type": "DWord", "Value": "1", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\CloudContent", "Name": "DisableConsumerAccountStateContent", "Type": "DWord", "Value": "1", "OriginalValue": "<RemoveEntry>" }
    ]
  },

  "MedProTweaksSuggestions": {
    "Content": "Start Menu and Lock Screen Suggestions - Disable",
    "Description": "Turns off suggested apps in Start, tips and tricks notifications, Spotlight lock screen advertising, and silent app installs from the Store.",
    "category": "Essential Tweaks",
    "recommended": true,
    "restartExplorer": true,
    "registry": [
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager", "Name": "ContentDeliveryAllowed", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager", "Name": "OemPreInstalledAppsEnabled", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager", "Name": "PreInstalledAppsEnabled", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager", "Name": "SilentInstalledAppsEnabled", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager", "Name": "SystemPaneSuggestionsEnabled", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager", "Name": "SoftLandingEnabled", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager", "Name": "RotatingLockScreenOverlayEnabled", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager", "Name": "SubscribedContent-338388Enabled", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager", "Name": "SubscribedContent-338389Enabled", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager", "Name": "SubscribedContent-338393Enabled", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager", "Name": "SubscribedContent-353694Enabled", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager", "Name": "SubscribedContent-353696Enabled", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager", "Name": "SubscribedContent-310093Enabled", "Type": "DWord", "Value": "0", "OriginalValue": "1" }
    ]
  },

  "MedProTweaksDeliveryOptimization": {
    "Content": "Delivery Optimization - Disable",
    "Description": "Stops this machine uploading Windows update content to other PCs over the internet. Useful on metered or shared office links.",
    "category": "Essential Tweaks",
    "recommended": true,
    "registry": [
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\DeliveryOptimization", "Name": "DODownloadMode", "Type": "DWord", "Value": "0", "OriginalValue": "<RemoveEntry>" }
    ]
  },

  "MedProTweaksLocation": {
    "Content": "Location Tracking - Disable",
    "Description": "Turns off the Windows location service and denies location access system-wide. Do not apply if a MedPro application requires location.",
    "category": "Essential Tweaks",
    "recommended": true,
    "registry": [
      { "Path": "HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\CapabilityAccessManager\\ConsentStore\\location", "Name": "Value", "Type": "String", "Value": "Deny", "OriginalValue": "Allow" },
      { "Path": "HKLM:\\SYSTEM\\CurrentControlSet\\Services\\lfsvc\\Service\\Configuration", "Name": "Status", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKLM:\\SYSTEM\\Maps", "Name": "AutoUpdateEnabled", "Type": "DWord", "Value": "0", "OriginalValue": "1" }
    ]
  },

  "MedProTweaksWidgets": {
    "Content": "Widgets and News Feed - Disable",
    "Description": "Removes the Widgets button from the taskbar and blocks the news and interests feed.",
    "category": "Essential Tweaks",
    "recommended": true,
    "restartExplorer": true,
    "registry": [
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Dsh", "Name": "AllowNewsAndInterests", "Type": "DWord", "Value": "0", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced", "Name": "TaskbarDa", "Type": "DWord", "Value": "0", "OriginalValue": "1" }
    ]
  },

  "MedProTweaksCopilot": {
    "Content": "Copilot and Recall - Disable",
    "Description": "Turns off Windows Copilot and blocks Recall from analysing screen content. Applied on every MedPro machine: Recall captures whatever is on screen, which on a staffing workstation means candidate and client data.",
    "category": "Essential Tweaks",
    "recommended": true,
    "restartExplorer": true,
    "registry": [
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsAI", "Name": "DisableAIDataAnalysis", "Type": "DWord", "Value": "1", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsCopilot", "Name": "TurnOffWindowsCopilot", "Type": "DWord", "Value": "1", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKCU:\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsCopilot", "Name": "TurnOffWindowsCopilot", "Type": "DWord", "Value": "1", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced", "Name": "ShowCopilotButton", "Type": "DWord", "Value": "0", "OriginalValue": "1" }
    ]
  },

  "MedProTweaksWPBT": {
    "Content": "Windows Platform Binary Table - Disable",
    "Description": "Stops the firmware injecting and running vendor executables into Windows at every boot. This is how some OEM machines keep reinstalling their own software after a clean image.",
    "category": "Essential Tweaks",
    "recommended": true,
    "restartRequired": true,
    "registry": [
      { "Path": "HKLM:\\SYSTEM\\CurrentControlSet\\Control\\Session Manager", "Name": "DisableWpbtExecution", "Type": "DWord", "Value": "1", "OriginalValue": "0" }
    ]
  },

  "MedProTweaksDeviceMetadata": {
    "Content": "Device Companion App Prompts - Disable",
    "Description": "Stops Windows fetching device metadata from the internet and prompting users to install manufacturer companion apps when hardware is plugged in.",
    "category": "Essential Tweaks",
    "recommended": true,
    "registry": [
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\Device Metadata", "Name": "PreventDeviceMetadataFromNetwork", "Type": "DWord", "Value": "1", "OriginalValue": "<RemoveEntry>" }
    ]
  },

  "MedProTweaksSyncNotifications": {
    "Content": "File Explorer Ads - Disable",
    "Description": "Removes the promotional banners Microsoft shows inside File Explorer for OneDrive and Microsoft 365. Does not affect OneDrive sync itself.",
    "category": "Essential Tweaks",
    "recommended": true,
    "restartExplorer": true,
    "registry": [
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced", "Name": "ShowSyncProviderNotifications", "Type": "DWord", "Value": "0", "OriginalValue": "1" }
    ]
  },

  "MedProTweaksBackgroundApps": {
    "Content": "Background Apps - Disable",
    "Description": "Stops Store apps running in the background when they are not open. Frees memory and battery on lower-spec machines.",
    "category": "Essential Tweaks",
    "recommended": true,
    "registry": [
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\BackgroundAccessApplications", "Name": "GlobalUserDisabled", "Type": "DWord", "Value": "1", "OriginalValue": "0" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Search", "Name": "BackgroundAppGlobalToggle", "Type": "DWord", "Value": "0", "OriginalValue": "1" }
    ]
  },

  "MedProTweaksServices": {
    "Content": "Unused Services - Disable",
    "Description": "Disables Xbox, Fax, Maps, Retail Demo, and parental control services that have no role on a MedPro workstation. Search, printing, and networking services are deliberately left alone. Takes effect after a reboot.",
    "category": "Essential Tweaks",
    "recommended": true,
    "restartRequired": true,
    "service": [
      { "Name": "MapsBroker", "StartupType": "Disabled", "OriginalType": "Automatic" },
      { "Name": "RetailDemo", "StartupType": "Disabled", "OriginalType": "Manual" },
      { "Name": "Fax", "StartupType": "Disabled", "OriginalType": "Manual" },
      { "Name": "XblAuthManager", "StartupType": "Disabled", "OriginalType": "Manual" },
      { "Name": "XblGameSave", "StartupType": "Disabled", "OriginalType": "Manual" },
      { "Name": "XboxGipSvc", "StartupType": "Disabled", "OriginalType": "Manual" },
      { "Name": "XboxNetApiSvc", "StartupType": "Disabled", "OriginalType": "Manual" },
      { "Name": "WpcMonSvc", "StartupType": "Disabled", "OriginalType": "Manual" },
      { "Name": "AJRouter", "StartupType": "Disabled", "OriginalType": "Manual" },
      { "Name": "SEMgrSvc", "StartupType": "Disabled", "OriginalType": "Manual" }
    ]
  },

  "MedProTweaksEndTask": {
    "Content": "End Task on Taskbar Right-Click - Enable",
    "Description": "Adds End Task to the taskbar right-click menu so a hung application can be killed without opening Task Manager. Saves a support call.",
    "category": "Essential Tweaks",
    "recommended": true,
    "restartExplorer": true,
    "registry": [
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced\\TaskbarDeveloperSettings", "Name": "TaskbarEndTask", "Type": "DWord", "Value": "1", "OriginalValue": "0" }
    ]
  },

  "MedProTweaksLongPaths": {
    "Content": "Long File Paths - Enable",
    "Description": "Lifts the 260-character path limit. Prevents failures when users nest deep folders on mapped drives or in synced document libraries.",
    "category": "Essential Tweaks",
    "recommended": true,
    "restartRequired": true,
    "registry": [
      { "Path": "HKLM:\\SYSTEM\\CurrentControlSet\\Control\\FileSystem", "Name": "LongPathsEnabled", "Type": "DWord", "Value": "1", "OriginalValue": "0" }
    ]
  },

  "MedProTweaksVerboseLogon": {
    "Content": "Verbose Logon Messages - Enable",
    "Description": "Shows what Windows is actually doing during sign-in and shutdown instead of a spinner. Makes slow logons and stuck Group Policy diagnosable on the spot.",
    "category": "Essential Tweaks",
    "recommended": true,
    "registry": [
      { "Path": "HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System", "Name": "VerboseStatus", "Type": "DWord", "Value": "1", "OriginalValue": "0" }
    ]
  },

  "MedProTweaksDetailedBSoD": {
    "Content": "Detailed Blue Screen - Enable",
    "Description": "Shows the stop code and failing driver on a blue screen instead of only a sad face and a QR code. Turns an unhelpful crash report into a usable one.",
    "category": "Essential Tweaks",
    "recommended": true,
    "registry": [
      { "Path": "HKLM:\\SYSTEM\\CurrentControlSet\\Control\\CrashControl", "Name": "DisplayParameters", "Type": "DWord", "Value": "1", "OriginalValue": "0" }
    ]
  },

  "MedProTweaksDarkMode": {
    "Content": "Dark Theme - Enable",
    "Description": "Switches Windows and app chrome to the dark theme.",
    "category": "Interface Preferences",
    "categoryNote": "Cosmetic and workflow settings applied to the signed-in user. These change what people see, so pick them to match how the machine will be used.",
    "restartExplorer": true,
    "registry": [
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize", "Name": "AppsUseLightTheme", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize", "Name": "SystemUsesLightTheme", "Type": "DWord", "Value": "0", "OriginalValue": "1" }
    ]
  },

  "MedProTweaksShowFileExtensions": {
    "Content": "File Extensions - Show",
    "Description": "Shows file extensions in File Explorer. A security control as much as a convenience one: it is how a user notices that invoice.pdf.exe is not a PDF.",
    "category": "Interface Preferences",
    "recommended": true,
    "restartExplorer": true,
    "registry": [
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced", "Name": "HideFileExt", "Type": "DWord", "Value": "0", "OriginalValue": "1" }
    ]
  },

  "MedProTweaksShowHiddenFiles": {
    "Content": "Hidden Files - Show",
    "Description": "Shows hidden files and folders in File Explorer. Useful on a technician's machine, noisy on an end user's.",
    "category": "Interface Preferences",
    "restartExplorer": true,
    "registry": [
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced", "Name": "Hidden", "Type": "DWord", "Value": "1", "OriginalValue": "2" }
    ]
  },

  "MedProTweaksTaskbarLeft": {
    "Content": "Taskbar - Align Left",
    "Description": "Moves the Start button and taskbar icons to the left, as in Windows 10. Eases the transition for staff moving from older machines.",
    "category": "Interface Preferences",
    "recommended": true,
    "restartExplorer": true,
    "registry": [
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced", "Name": "TaskbarAl", "Type": "DWord", "Value": "0", "OriginalValue": "1" }
    ]
  },

  "MedProTweaksHideTaskView": {
    "Content": "Taskbar Task View Button - Hide",
    "Description": "Removes the Task View button from the taskbar. Alt-Tab and Win-Tab still work.",
    "category": "Interface Preferences",
    "restartExplorer": true,
    "registry": [
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced", "Name": "ShowTaskViewButton", "Type": "DWord", "Value": "0", "OriginalValue": "1" }
    ]
  },

  "MedProTweaksSearchIconOnly": {
    "Content": "Taskbar Search - Icon Only",
    "Description": "Collapses the taskbar search box down to a single icon, reclaiming taskbar space for pinned applications.",
    "category": "Interface Preferences",
    "recommended": true,
    "restartExplorer": true,
    "registry": [
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Search", "Name": "SearchboxTaskbarMode", "Type": "DWord", "Value": "1", "OriginalValue": "2" }
    ]
  },

  "MedProTweaksDisableBingSearch": {
    "Content": "Start Menu Web Search - Disable",
    "Description": "Stops the Start menu sending what users type to Bing and showing web results. Start menu search then only returns local apps, settings, and files.",
    "category": "Interface Preferences",
    "recommended": true,
    "restartExplorer": true,
    "registry": [
      { "Path": "HKCU:\\SOFTWARE\\Policies\\Microsoft\\Windows\\Explorer", "Name": "DisableSearchBoxSuggestions", "Type": "DWord", "Value": "1", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Search", "Name": "BingSearchEnabled", "Type": "DWord", "Value": "0", "OriginalValue": "1" }
    ]
  },

  "MedProTweaksStartRecommendations": {
    "Content": "Start Menu Recommended Section - Hide",
    "Description": "Hides the Recommended list of recent files and suggested apps at the bottom of the Start menu. Requires Windows 11 Pro, Enterprise, or Education.",
    "category": "Interface Preferences",
    "recommended": true,
    "restartExplorer": true,
    "registry": [
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\Explorer", "Name": "HideRecommendedSection", "Type": "DWord", "Value": "1", "OriginalValue": "<RemoveEntry>" }
    ]
  },

  "MedProTweaksClassicContextMenu": {
    "Content": "Classic Right-Click Menu - Restore",
    "Description": "Brings back the full Windows 10 context menu instead of the trimmed Windows 11 one, removing the extra Show more options click.",
    "category": "Interface Preferences",
    "recommended": true,
    "restartExplorer": true,
    "InvokeScript": [
      "New-Item -Path 'HKCU:\\SOFTWARE\\Classes\\CLSID\\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\\InprocServer32' -Force -Value '' | Out-Null"
    ],
    "UndoScript": [
      "Remove-Item -Path 'HKCU:\\SOFTWARE\\Classes\\CLSID\\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}' -Recurse -Force -ErrorAction SilentlyContinue"
    ]
  },

  "MedProTweaksMouseAcceleration": {
    "Content": "Mouse Acceleration - Disable",
    "Description": "Turns off enhanced pointer precision so cursor movement maps one to one with the mouse.",
    "category": "Interface Preferences",
    "registry": [
      { "Path": "HKCU:\\Control Panel\\Mouse", "Name": "MouseSpeed", "Type": "String", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\Control Panel\\Mouse", "Name": "MouseThreshold1", "Type": "String", "Value": "0", "OriginalValue": "6" },
      { "Path": "HKCU:\\Control Panel\\Mouse", "Name": "MouseThreshold2", "Type": "String", "Value": "0", "OriginalValue": "10" }
    ]
  },

  "MedProTweaksNumLock": {
    "Content": "Num Lock on Startup - Enable",
    "Description": "Turns Num Lock on at the sign-in screen. Prevents the classic support call where a PIN or password will not type on a desktop keyboard.",
    "category": "Interface Preferences",
    "recommended": true,
    "registry": [
      { "Path": "HKU:\\.DEFAULT\\Control Panel\\Keyboard", "Name": "InitialKeyboardIndicators", "Type": "String", "Value": "2", "OriginalValue": "2147483648" },
      { "Path": "HKCU:\\Control Panel\\Keyboard", "Name": "InitialKeyboardIndicators", "Type": "String", "Value": "2", "OriginalValue": "2147483648" }
    ]
  },

  "MedProTweaksStickyKeys": {
    "Content": "Sticky Keys Prompt - Disable",
    "Description": "Stops the accessibility prompt that appears when Shift is pressed five times.",
    "category": "Interface Preferences",
    "recommended": true,
    "registry": [
      { "Path": "HKCU:\\Control Panel\\Accessibility\\StickyKeys", "Name": "Flags", "Type": "String", "Value": "506", "OriginalValue": "510" }
    ]
  },

  "MedProTweaksVisualEffects": {
    "Content": "Visual Effects - Best Performance",
    "Description": "Turns off window animations, shadows, and fades. A visible speed-up on older or low-spec hardware, and a noticeably plainer desktop that users will comment on.",
    "category": "Advanced Tweaks - Caution",
    "categoryNote": "These change Windows in ways users will notice, or interact with software MedPro may depend on. Read the tooltip before ticking one.",
    "caution": true,
    "restartExplorer": true,
    "registry": [
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\VisualEffects", "Name": "VisualFXSetting", "Type": "DWord", "Value": "2", "OriginalValue": "0" },
      { "Path": "HKCU:\\Control Panel\\Desktop", "Name": "UserPreferencesMask", "Type": "Binary", "Value": [144, 18, 3, 128, 16, 0, 0, 0], "OriginalValue": [158, 30, 7, 128, 18, 0, 0, 0] },
      { "Path": "HKCU:\\Control Panel\\Desktop", "Name": "DragFullWindows", "Type": "String", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\Control Panel\\Desktop", "Name": "MenuShowDelay", "Type": "String", "Value": "100", "OriginalValue": "400" },
      { "Path": "HKCU:\\Control Panel\\Desktop\\WindowMetrics", "Name": "MinAnimate", "Type": "String", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced", "Name": "TaskbarAnimations", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced", "Name": "ListviewAlphaSelect", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced", "Name": "ListviewShadow", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\DWM", "Name": "EnableAeroPeek", "Type": "DWord", "Value": "0", "OriginalValue": "1" }
    ]
  },

  "MedProTweaksEdgeDebloat": {
    "Content": "Microsoft Edge - Debloat",
    "Description": "Turns off Edge shopping, rewards, collections, sidebar widgets, crypto wallet, first-run experience, and diagnostic reporting via policy. Edge itself stays installed and working.",
    "category": "Advanced Tweaks - Caution",
    "caution": true,
    "registry": [
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge", "Name": "HideFirstRunExperience", "Type": "DWord", "Value": "1", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge", "Name": "PersonalizationReportingEnabled", "Type": "DWord", "Value": "0", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge", "Name": "ShowRecommendationsEnabled", "Type": "DWord", "Value": "0", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge", "Name": "UserFeedbackAllowed", "Type": "DWord", "Value": "0", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge", "Name": "ConfigureDoNotTrack", "Type": "DWord", "Value": "1", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge", "Name": "EdgeCollectionsEnabled", "Type": "DWord", "Value": "0", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge", "Name": "EdgeShoppingAssistantEnabled", "Type": "DWord", "Value": "0", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge", "Name": "ShowMicrosoftRewards", "Type": "DWord", "Value": "0", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge", "Name": "WebWidgetAllowed", "Type": "DWord", "Value": "0", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge", "Name": "DiagnosticData", "Type": "DWord", "Value": "0", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge", "Name": "CryptoWalletEnabled", "Type": "DWord", "Value": "0", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge", "Name": "WalletDonationEnabled", "Type": "DWord", "Value": "0", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge", "Name": "MicrosoftEdgeInsiderPromotionEnabled", "Type": "DWord", "Value": "0", "OriginalValue": "<RemoveEntry>" }
    ]
  },

  "MedProTweaksRemoveOneDrive": {
    "Content": "OneDrive - Remove",
    "Description": "DO NOT APPLY if MedPro uses OneDrive Known Folder Move to back up Desktop and Documents. This uninstalls the OneDrive client; anything not yet synced is lost with the profile. Only for machines where OneDrive is not part of the build.",
    "category": "Advanced Tweaks - Caution",
    "caution": true,
    "restartExplorer": true,
    "InvokeScript": [
      "Get-Process -Name OneDrive -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue",
      "$setup = \"$env:SystemRoot\\SysWOW64\\OneDriveSetup.exe\"; if (-not (Test-Path $setup)) { $setup = \"$env:SystemRoot\\System32\\OneDriveSetup.exe\" }; if (Test-Path $setup) { Start-Process $setup -ArgumentList '/uninstall' -Wait -NoNewWindow } else { Write-MedProLog '  OneDriveSetup.exe not found - OneDrive may already be removed.' }"
    ],
    "UndoScript": [
      "$setup = \"$env:SystemRoot\\SysWOW64\\OneDriveSetup.exe\"; if (-not (Test-Path $setup)) { $setup = \"$env:SystemRoot\\System32\\OneDriveSetup.exe\" }; if (Test-Path $setup) { Start-Process $setup -Wait -NoNewWindow } else { Write-MedProLog '  OneDriveSetup.exe is gone - reinstall OneDrive from the Install tab.' }"
    ]
  },

  "MedProTweaksStorageSense": {
    "Content": "Storage Sense - Disable",
    "Description": "Stops Windows automatically deleting temporary files and old items from the Recycle Bin and Downloads folder.",
    "category": "Advanced Tweaks - Caution",
    "caution": true,
    "registry": [
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\StorageSense\\Parameters\\StoragePolicy", "Name": "01", "Type": "DWord", "Value": "0", "OriginalValue": "1" }
    ]
  },

  "MedProTweaksReservedStorage": {
    "Content": "Reserved Storage - Disable",
    "Description": "Reclaims the several gigabytes Windows sets aside for updates. Fails if updates are pending, and may make future feature updates need free space they cannot find.",
    "category": "Advanced Tweaks - Caution",
    "caution": true,
    "InvokeScript": [
      "Set-WindowsReservedStorageState -State Disabled -ErrorAction Stop"
    ],
    "UndoScript": [
      "Set-WindowsReservedStorageState -State Enabled -ErrorAction Stop"
    ]
  },

  "MedProTweaksHibernation": {
    "Content": "Hibernation - Disable",
    "Description": "NOT FOR LAPTOPS. Frees disk space equal to a large share of installed RAM, but removes hibernate and disables Fast Startup. On a laptop this means a flat battery loses open work.",
    "category": "Advanced Tweaks - Caution",
    "caution": true,
    "registry": [
      { "Path": "HKLM:\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Power", "Name": "HibernateEnabled", "Type": "DWord", "Value": "0", "OriginalValue": "1" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\FlyoutMenuSettings", "Name": "ShowHibernateOption", "Type": "DWord", "Value": "0", "OriginalValue": "1" }
    ],
    "InvokeScript": [ "powercfg.exe /hibernate off" ],
    "UndoScript":   [ "powercfg.exe /hibernate on" ]
  },

  "MedProTweaksPreferIPv4": {
    "Content": "IPv4 - Prefer over IPv6",
    "Description": "Makes Windows try IPv4 first. Can resolve slow name resolution and VPN routing problems on IPv4-only networks. IPv6 remains available.",
    "category": "Advanced Tweaks - Caution",
    "caution": true,
    "restartRequired": true,
    "registry": [
      { "Path": "HKLM:\\SYSTEM\\CurrentControlSet\\Services\\Tcpip6\\Parameters", "Name": "DisabledComponents", "Type": "DWord", "Value": "32", "OriginalValue": "<RemoveEntry>" }
    ]
  },

  "MedProTweaksUnsignedRdp": {
    "Content": "Unsigned RDP File Warnings - Disable",
    "Description": "Stops the publisher-cannot-be-identified prompt every time a technician opens an internal .rdp file. Only apply on IT machines, and only where .rdp files come from a trusted internal source.",
    "category": "Advanced Tweaks - Caution",
    "caution": true,
    "registry": [
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Terminal Server Client", "Name": "AuthenticationLevelOverride", "Type": "DWord", "Value": "0", "OriginalValue": "<RemoveEntry>" }
    ]
  },

  "MedProTweaksDisableNotifications": {
    "Content": "Notification Centre - Disable",
    "Description": "Suppresses toast notifications and the notification centre entirely. Users will stop seeing Teams and Outlook alerts, so this suits kiosk and shared machines rather than staff desktops.",
    "category": "Advanced Tweaks - Caution",
    "caution": true,
    "restartExplorer": true,
    "registry": [
      { "Path": "HKCU:\\SOFTWARE\\Policies\\Microsoft\\Windows\\Explorer", "Name": "DisableNotificationCenter", "Type": "DWord", "Value": "1", "OriginalValue": "<RemoveEntry>" },
      { "Path": "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\PushNotifications", "Name": "ToastEnabled", "Type": "DWord", "Value": "0", "OriginalValue": "1" }
    ]
  },

  "MedProTweaksExplorerHomeGallery": {
    "Content": "File Explorer Home and Gallery - Remove",
    "Description": "Removes the Home and Gallery entries from the File Explorer sidebar so it opens to This PC and the mapped drives instead of recent cloud files.",
    "category": "Advanced Tweaks - Caution",
    "caution": true,
    "restartExplorer": true,
    "InvokeScript": [
      "Remove-Item -Path 'HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Desktop\\NameSpace_41040327\\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}' -Recurse -Force -ErrorAction SilentlyContinue",
      "Remove-Item -Path 'HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Desktop\\NameSpace_36354489\\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}' -Recurse -Force -ErrorAction SilentlyContinue"
    ],
    "UndoScript": [
      "New-Item -Path 'HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Desktop\\NameSpace_41040327\\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}' -Force | Out-Null",
      "New-Item -Path 'HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Desktop\\NameSpace_36354489\\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}' -Force | Out-Null"
    ]
  },

  "MedProTweaksFullscreenOptimizations": {
    "Content": "Fullscreen Optimizations - Disable",
    "Description": "Makes fullscreen applications take exclusive control of the display instead of running in a borderless window. Helps with stuttering or input lag in imaging and video review software.",
    "category": "Advanced Tweaks - Caution",
    "caution": true,
    "registry": [
      { "Path": "HKCU:\\System\\GameConfigStore", "Name": "GameDVR_FSEBehaviorMode", "Type": "DWord", "Value": "2", "OriginalValue": "0" },
      { "Path": "HKCU:\\System\\GameConfigStore", "Name": "GameDVR_HonorUserFSEBehaviorMode", "Type": "DWord", "Value": "1", "OriginalValue": "0" },
      { "Path": "HKCU:\\System\\GameConfigStore", "Name": "GameDVR_DXGIHonorFSEWindowsCompatible", "Type": "DWord", "Value": "1", "OriginalValue": "0" },
      { "Path": "HKCU:\\System\\GameConfigStore", "Name": "GameDVR_EFSEFeatureFlags", "Type": "DWord", "Value": "0", "OriginalValue": "1" }
    ]
  },

  "MedProTweaksRestorePoint": {
    "Content": "Restore Point - Create Now",
    "Description": "Creates a named system restore point immediately. Run this before installing an unfamiliar line-of-business application.",
    "category": "Maintenance Actions",
    "categoryNote": "One-time operations. These do something once rather than changing a setting, so they cannot be reversed with the Undo button.",
    "action": true,
    "InvokeScript": [
      "New-MedProRestorePoint -Description 'MedPro Utility - manual checkpoint' | Out-Null"
    ]
  },

  "MedProTweaksDiskCleanup": {
    "Content": "Disk Cleanup - Run",
    "Description": "Runs Windows Disk Cleanup and compacts the component store. Recovers several gigabytes on a machine that has taken feature updates. Can take fifteen minutes or more.",
    "category": "Maintenance Actions",
    "action": true,
    "InvokeScript": [
      "Write-MedProLog '  running cleanmgr...'; Start-Process -FilePath cleanmgr.exe -ArgumentList '/sagerun:1' -Wait -NoNewWindow",
      "Write-MedProLog '  compacting the component store (this is the slow part)...'; Start-Process -FilePath dism.exe -ArgumentList '/Online','/Cleanup-Image','/StartComponentCleanup','/ResetBase' -Wait -NoNewWindow"
    ]
  },

  "MedProTweaksTempFiles": {
    "Content": "Temporary Files - Delete",
    "Description": "Empties the user and system temp folders. Files locked by running applications are left alone.",
    "category": "Maintenance Actions",
    "action": true,
    "InvokeScript": [
      "foreach ($folder in @($env:TEMP, \"$env:SystemRoot\\Temp\")) { if (Test-Path $folder) { $before = @(Get-ChildItem -Path $folder -Recurse -Force -ErrorAction SilentlyContinue).Count; Get-ChildItem -Path $folder -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue; $after = @(Get-ChildItem -Path $folder -Recurse -Force -ErrorAction SilentlyContinue).Count; Write-MedProLog \"  $folder - removed $($before - $after) of $before items\" } }"
    ]
  },

  "MedProTweaksFlushDns": {
    "Content": "DNS Cache - Flush",
    "Description": "Clears the resolver cache. First thing to try when a machine reaches an old IP for an internal service after a DNS change.",
    "category": "Maintenance Actions",
    "action": true,
    "InvokeScript": [
      "Clear-DnsClientCache; Write-MedProLog '  DNS resolver cache cleared.'"
    ]
  }
}
'@ | ConvertFrom-Json

#endregion

#region Interface
$sync.xamlText = @'
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="MedPro Utility"
    Height="1000" Width="1600"
    MinHeight="620" MinWidth="940"
    WindowStartupLocation="CenterScreen"
    Background="#faf9fc"
    UseLayoutRounding="True"
    TextOptions.TextFormattingMode="Ideal"
    FontFamily="Sofia Pro, Poppins, Segoe UI"
    FontSize="14">

    <Window.Resources>

        <!-- ================================================================
             MedPro Healthcare Staffing design system.

             Colour, type, shape, elevation and motion all come from the brand
             tokens. Purple anchors the system, Coral is the call to action,
             Teal and Lavender are accents only. Resource keys are kept stable
             because Add-MedProCheckBoxCards resolves several of them by name.
             ================================================================ -->

        <!-- Brand core -->
        <SolidColorBrush x:Key="Purple"     Color="#48256b"/>  <!-- MedPro Purple   -->
        <SolidColorBrush x:Key="Coral"      Color="#f26c58"/>  <!-- MedPro Coral    -->
        <SolidColorBrush x:Key="Teal"       Color="#1fb5b0"/>  <!-- MedPro Teal     -->
        <SolidColorBrush x:Key="Lavender"   Color="#9883e5"/>  <!-- MedPro Lavender -->

        <!-- Hover steps: one stop darker, per the interaction spec -->
        <SolidColorBrush x:Key="PurpleDark" Color="#321a4b"/>
        <SolidColorBrush x:Key="CoralDark"  Color="#d64a3a"/>

        <!-- Purple-tinted neutrals -->
        <SolidColorBrush x:Key="Ink"        Color="#1c1426"/>  <!-- near-black, purple-tinted -->
        <SolidColorBrush x:Key="Graphite"   Color="#7b7384"/>  <!-- grey-500, muted text      -->
        <SolidColorBrush x:Key="Fog"        Color="#faf9fc"/>  <!-- grey-50, page             -->
        <SolidColorBrush x:Key="Snow"       Color="#ffffff"/>
        <SolidColorBrush x:Key="SilverMist" Color="#e8e4ed"/>  <!-- grey-200, hairline border -->
        <SolidColorBrush x:Key="Slate"      Color="#d3ced9"/>  <!-- grey-300, control border  -->
        <SolidColorBrush x:Key="PlumTint"   Color="#f0ebf7"/>  <!-- plum-100, hover surface   -->

        <!-- Status. Caution items use Danger rather than Coral: Coral is the
             call-to-action colour and reads at only 3:1 on white, which is not
             enough for a 14px label a technician has to actually read. -->
        <SolidColorBrush x:Key="Caution"    Color="#d8413f"/>

        <!-- Sofia Pro is the brand face (Adobe Fonts, licensed). Poppins is the
             free stand-in and is listed second so a workstation with either one
             installed picks up the real thing automatically. -->
        <FontFamily x:Key="DisplayFont">Sofia Pro, Poppins, Segoe UI Variable Display, Segoe UI</FontFamily>
        <FontFamily x:Key="TextFont">Sofia Pro, Poppins, Segoe UI</FontFamily>

        <!-- Soft, plum-tinted elevation. Never a neutral grey drop shadow. -->
        <DropShadowEffect x:Key="ShadowSm" Color="#48256b" BlurRadius="8"  ShadowDepth="2" Direction="270" Opacity="0.08"/>
        <DropShadowEffect x:Key="ShadowXs" Color="#48256b" BlurRadius="4"  ShadowDepth="1" Direction="270" Opacity="0.06"/>

        <!-- ================================================================
             Typography.

             Headline  - Light, sentence case, ends with a period.
             Subhead   - Bold, sentence case.
             Alt subhead - Bold, ALL CAPS, tracked out.
             Body      - Light, sentence case.

             Sizes sit at the lower end of the brand scale because this is a
             dense technician tool that has to fit on one screen; the weights,
             casing and colour roles are the brand's exactly.
             ================================================================ -->
        <Style x:Key="Headline" TargetType="TextBlock">
            <Setter Property="FontFamily" Value="{StaticResource DisplayFont}"/>
            <Setter Property="FontSize"   Value="24"/>
            <Setter Property="FontWeight" Value="Light"/>
            <Setter Property="Foreground" Value="{StaticResource Purple}"/>
        </Style>

        <!-- Card and section titles are primary subheads, not headlines. -->
        <Style x:Key="Heading" TargetType="TextBlock">
            <Setter Property="FontFamily" Value="{StaticResource DisplayFont}"/>
            <Setter Property="FontSize"   Value="18"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Foreground" Value="{StaticResource Purple}"/>
        </Style>

        <Style x:Key="Subheading" TargetType="TextBlock">
            <Setter Property="FontFamily" Value="{StaticResource DisplayFont}"/>
            <Setter Property="FontSize"   Value="15"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Foreground" Value="{StaticResource Purple}"/>
        </Style>

        <Style x:Key="Body" TargetType="TextBlock">
            <Setter Property="FontSize"     Value="13.5"/>
            <Setter Property="FontWeight"   Value="Light"/>
            <Setter Property="Foreground"   Value="{StaticResource Graphite}"/>
            <Setter Property="TextWrapping" Value="Wrap"/>
            <Setter Property="LineHeight"   Value="19"/>
        </Style>

        <Style x:Key="Caption" TargetType="TextBlock">
            <Setter Property="FontSize"   Value="12"/>
            <Setter Property="FontWeight" Value="Light"/>
            <Setter Property="Foreground" Value="{StaticResource Graphite}"/>
        </Style>

        <!-- Alternate subhead. WPF has no letter-spacing property, so the
             tracking is carried by hair spaces written as XML entities - which
             keeps this file pure ASCII, the one thing the compiled single-file
             build cannot do without. -->
        <Style x:Key="CapsLabel" TargetType="TextBlock" BasedOn="{StaticResource Caption}">
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="FontSize"   Value="11"/>
            <Setter Property="Foreground" Value="{StaticResource Purple}"/>
        </Style>

        <!-- ================================================================
             Card - white surface, hairline border, soft plum-tinted lift.
             Padding is tighter than the brand's 24px marketing spec so a tab
             still fits on one screen.
             ================================================================ -->
        <Style x:Key="Card" TargetType="Border">
            <Setter Property="Background"      Value="{StaticResource Snow}"/>
            <Setter Property="BorderBrush"     Value="{StaticResource SilverMist}"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="CornerRadius"    Value="20"/>
            <Setter Property="Padding"         Value="18,12"/>
            <Setter Property="Margin"          Value="0,0,0,8"/>
            <Setter Property="Effect"          Value="{StaticResource ShadowSm}"/>
        </Style>

        <!-- Recessed panel: a light plum tint inside a white card, never the reverse -->
        <Style x:Key="RecessedCard" TargetType="Border" BasedOn="{StaticResource Card}">
            <Setter Property="Background"   Value="{StaticResource Fog}"/>
            <Setter Property="CornerRadius" Value="14"/>
            <Setter Property="Padding"      Value="12"/>
            <Setter Property="Effect"       Value="{x:Null}"/>
        </Style>

        <!-- ================================================================
             Buttons
             ================================================================ -->
        <!-- Every button is a halfpipe - a pill with fully rounded ends. Hover
             darkens one step and lifts 2px; press settles back to 0.97 scale
             with no colour flash. Durations sit in the brand's 120-320ms band. -->
        <Style x:Key="PillButtonBase" TargetType="Button">
            <Setter Property="FontFamily"  Value="{StaticResource TextFont}"/>
            <Setter Property="FontSize"    Value="13.5"/>
            <Setter Property="FontWeight"  Value="SemiBold"/>
            <Setter Property="Foreground"  Value="{StaticResource Snow}"/>
            <Setter Property="Padding"     Value="20,8"/>
            <Setter Property="Cursor"      Value="Hand"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <!-- The transforms are addressed by index rather than by
                             x:Name: a Setter cannot target a Freezable inside a
                             template, so the lift and the press both run as
                             storyboards over the group's children. -->
                        <Border x:Name="Pill"
                                Background="{TemplateBinding Background}"
                                CornerRadius="17"
                                Padding="{TemplateBinding Padding}"
                                RenderTransformOrigin="0.5,0.5">
                            <Border.RenderTransform>
                                <TransformGroup>
                                    <ScaleTransform/>
                                    <TranslateTransform/>
                                </TransformGroup>
                            </Border.RenderTransform>
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Trigger.EnterActions>
                                    <BeginStoryboard>
                                        <Storyboard>
                                            <DoubleAnimation Storyboard.TargetName="Pill"
                                                             Storyboard.TargetProperty="(UIElement.RenderTransform).(TransformGroup.Children)[1].(TranslateTransform.Y)"
                                                             To="-2" Duration="0:0:0.12">
                                                <DoubleAnimation.EasingFunction>
                                                    <CubicEase EasingMode="EaseOut"/>
                                                </DoubleAnimation.EasingFunction>
                                            </DoubleAnimation>
                                        </Storyboard>
                                    </BeginStoryboard>
                                </Trigger.EnterActions>
                                <Trigger.ExitActions>
                                    <BeginStoryboard>
                                        <Storyboard>
                                            <DoubleAnimation Storyboard.TargetName="Pill"
                                                             Storyboard.TargetProperty="(UIElement.RenderTransform).(TransformGroup.Children)[1].(TranslateTransform.Y)"
                                                             To="0" Duration="0:0:0.12"/>
                                        </Storyboard>
                                    </BeginStoryboard>
                                </Trigger.ExitActions>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Trigger.EnterActions>
                                    <BeginStoryboard>
                                        <Storyboard>
                                            <DoubleAnimation Storyboard.TargetName="Pill"
                                                             Storyboard.TargetProperty="(UIElement.RenderTransform).(TransformGroup.Children)[0].(ScaleTransform.ScaleX)"
                                                             To="0.97" Duration="0:0:0.09"/>
                                            <DoubleAnimation Storyboard.TargetName="Pill"
                                                             Storyboard.TargetProperty="(UIElement.RenderTransform).(TransformGroup.Children)[0].(ScaleTransform.ScaleY)"
                                                             To="0.97" Duration="0:0:0.09"/>
                                        </Storyboard>
                                    </BeginStoryboard>
                                </Trigger.EnterActions>
                                <Trigger.ExitActions>
                                    <BeginStoryboard>
                                        <Storyboard>
                                            <DoubleAnimation Storyboard.TargetName="Pill"
                                                             Storyboard.TargetProperty="(UIElement.RenderTransform).(TransformGroup.Children)[0].(ScaleTransform.ScaleX)"
                                                             To="1" Duration="0:0:0.09"/>
                                            <DoubleAnimation Storyboard.TargetName="Pill"
                                                             Storyboard.TargetProperty="(UIElement.RenderTransform).(TransformGroup.Children)[0].(ScaleTransform.ScaleY)"
                                                             To="1" Duration="0:0:0.09"/>
                                        </Storyboard>
                                    </BeginStoryboard>
                                </Trigger.ExitActions>
                            </Trigger>
                            <Trigger Property="IsEnabled" Value="False">
                                <Setter TargetName="Pill" Property="Opacity" Value="0.4"/>
                                <Setter Property="Cursor" Value="Arrow"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- Primary CTA. Coral is reserved for exactly one button per view. -->
        <Style x:Key="PrimaryButton" TargetType="Button" BasedOn="{StaticResource PillButtonBase}">
            <Setter Property="Background" Value="{StaticResource Coral}"/>
            <Style.Triggers>
                <Trigger Property="IsMouseOver" Value="True">
                    <Setter Property="Background" Value="{StaticResource CoralDark}"/>
                </Trigger>
            </Style.Triggers>
        </Style>

        <!-- Secondary action. Purple pill, used for undo and supporting actions. -->
        <Style x:Key="DarkPillButton" TargetType="Button" BasedOn="{StaticResource PillButtonBase}">
            <Setter Property="Background" Value="{StaticResource Purple}"/>
            <Style.Triggers>
                <Trigger Property="IsMouseOver" Value="True">
                    <Setter Property="Background" Value="{StaticResource PurpleDark}"/>
                </Trigger>
            </Style.Triggers>
        </Style>

        <!-- Ghost: purple text, no fill until hovered. -->
        <Style x:Key="GhostButton" TargetType="Button">
            <Setter Property="FontFamily" Value="{StaticResource TextFont}"/>
            <Setter Property="FontSize"   Value="13.5"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Foreground" Value="{StaticResource Purple}"/>
            <Setter Property="Padding"    Value="14,7"/>
            <Setter Property="Cursor"     Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="Chrome" Background="Transparent" CornerRadius="16" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Chrome" Property="Background" Value="{StaticResource PlumTint}"/>
                            </Trigger>
                            <Trigger Property="IsEnabled" Value="False">
                                <Setter Property="Foreground" Value="{StaticResource Graphite}"/>
                                <Setter Property="Opacity" Value="0.5"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- ================================================================
             Tabs
             ================================================================ -->
        <Style TargetType="TabControl">
            <Setter Property="Background"      Value="Transparent"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Padding"         Value="0"/>
        </Style>

        <!-- Teal underline marks the active tab. -->
        <Style TargetType="TabItem">
            <Setter Property="FontFamily" Value="{StaticResource TextFont}"/>
            <Setter Property="FontSize"   Value="14"/>
            <Setter Property="Foreground" Value="{StaticResource Graphite}"/>
            <Setter Property="Cursor"     Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TabItem">
                        <Border x:Name="Chrome"
                                Background="Transparent"
                                BorderBrush="Transparent"
                                BorderThickness="0,0,0,3"
                                Padding="18,9">
                            <ContentPresenter ContentSource="Header"
                                              HorizontalAlignment="Center"
                                              VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Foreground" Value="{StaticResource Purple}"/>
                            </Trigger>
                            <Trigger Property="IsSelected" Value="True">
                                <Setter TargetName="Chrome" Property="BorderBrush" Value="{StaticResource Teal}"/>
                                <Setter Property="Foreground" Value="{StaticResource Purple}"/>
                                <Setter Property="FontWeight" Value="Bold"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- ================================================================
             Checkbox - used heavily by the Tweaks and Install tabs
             ================================================================ -->
        <!-- Checked state is a solid MedPro Purple fill; focus and hover are
             teal. The tick box keeps a 6px radius rather than the system's 14
             - at 17px square, 14 would render as a circle and read as a radio
             button, which is wrong for a list a technician multi-selects. -->
        <Style x:Key="MedProCheckBox" TargetType="CheckBox">
            <Setter Property="Foreground" Value="{StaticResource Ink}"/>
            <Setter Property="FontSize"   Value="13.5"/>
            <Setter Property="FontWeight" Value="Light"/>
            <Setter Property="Margin"     Value="0"/>
            <Setter Property="Cursor"     Value="Hand"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="CheckBox">
                        <StackPanel Orientation="Horizontal" Background="Transparent">
                            <Border x:Name="Ring"
                                    CornerRadius="9"
                                    Background="Transparent"
                                    Padding="2"
                                    VerticalAlignment="Center">
                                <Border x:Name="Box"
                                        Width="17" Height="17"
                                        CornerRadius="6"
                                        Background="{StaticResource Snow}"
                                        BorderBrush="{StaticResource Slate}"
                                        BorderThickness="1.6">
                                    <Path x:Name="Tick"
                                          Data="M 0 3.5 L 3 6.5 L 8 0.5"
                                          Stroke="{StaticResource Snow}"
                                          StrokeThickness="1.8"
                                          StrokeEndLineCap="Round"
                                          StrokeStartLineCap="Round"
                                          Visibility="Collapsed"
                                          HorizontalAlignment="Center"
                                          VerticalAlignment="Center"/>
                                </Border>
                            </Border>
                            <ContentPresenter Margin="8,0,0,0" VerticalAlignment="Center"/>
                        </StackPanel>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsChecked" Value="True">
                                <Setter TargetName="Box"  Property="Background"  Value="{StaticResource Purple}"/>
                                <Setter TargetName="Box"  Property="BorderBrush" Value="{StaticResource Purple}"/>
                                <Setter TargetName="Tick" Property="Visibility"  Value="Visible"/>
                            </Trigger>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Box" Property="BorderBrush" Value="{StaticResource Teal}"/>
                            </Trigger>
                            <Trigger Property="IsKeyboardFocused" Value="True">
                                <Setter TargetName="Ring" Property="Background" Value="#731fb5b0"/>
                            </Trigger>
                            <Trigger Property="IsEnabled" Value="False">
                                <Setter Property="Opacity" Value="0.45"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- ================================================================
             Inputs
             ================================================================ -->
        <Style TargetType="ComboBoxItem">
            <Setter Property="Foreground" Value="{StaticResource Ink}"/>
            <Setter Property="FontSize"   Value="13.5"/>
            <Setter Property="FontWeight" Value="Light"/>
            <Setter Property="Padding"    Value="12,8"/>
            <Setter Property="Cursor"     Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="ComboBoxItem">
                        <Border x:Name="Chrome"
                                Background="Transparent"
                                CornerRadius="8"
                                Margin="4,2"
                                Padding="{TemplateBinding Padding}">
                            <ContentPresenter/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsHighlighted" Value="True">
                                <Setter TargetName="Chrome" Property="Background" Value="{StaticResource PlumTint}"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style TargetType="ComboBox">
            <Setter Property="Foreground" Value="{StaticResource Ink}"/>
            <Setter Property="FontSize"   Value="13.5"/>
            <Setter Property="FontWeight" Value="Light"/>
            <Setter Property="Cursor"     Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="ComboBox">
                        <Grid>
                            <ToggleButton x:Name="Toggle"
                                          Focusable="False"
                                          ClickMode="Press"
                                          IsChecked="{Binding IsDropDownOpen, Mode=TwoWay, RelativeSource={RelativeSource TemplatedParent}}">
                                <ToggleButton.Template>
                                    <ControlTemplate TargetType="ToggleButton">
                                        <Border x:Name="Chrome"
                                                Background="{StaticResource Fog}"
                                                BorderBrush="{StaticResource SilverMist}"
                                                BorderThickness="1"
                                                CornerRadius="14">
                                            <Path Data="M 0 0 L 4.5 4.5 L 9 0"
                                                  Stroke="{StaticResource Graphite}"
                                                  StrokeThickness="1.6"
                                                  StrokeStartLineCap="Round"
                                                  StrokeEndLineCap="Round"
                                                  HorizontalAlignment="Right"
                                                  VerticalAlignment="Center"
                                                  Margin="0,0,14,0"/>
                                        </Border>
                                        <ControlTemplate.Triggers>
                                            <Trigger Property="IsMouseOver" Value="True">
                                                <Setter TargetName="Chrome" Property="BorderBrush" Value="{StaticResource Teal}"/>
                                            </Trigger>
                                            <Trigger Property="IsChecked" Value="True">
                                                <Setter TargetName="Chrome" Property="BorderBrush" Value="{StaticResource Teal}"/>
                                                <Setter TargetName="Chrome" Property="BorderThickness" Value="2"/>
                                            </Trigger>
                                        </ControlTemplate.Triggers>
                                    </ControlTemplate>
                                </ToggleButton.Template>
                            </ToggleButton>

                            <ContentPresenter IsHitTestVisible="False"
                                              Content="{TemplateBinding SelectionBoxItem}"
                                              ContentTemplate="{TemplateBinding SelectionBoxItemTemplate}"
                                              Margin="14,0,32,0"
                                              VerticalAlignment="Center"
                                              HorizontalAlignment="Left"/>

                            <Popup x:Name="PART_Popup"
                                   Placement="Bottom"
                                   IsOpen="{TemplateBinding IsDropDownOpen}"
                                   AllowsTransparency="True"
                                   Focusable="False"
                                   PopupAnimation="Fade">
                                <Border Background="{StaticResource Snow}"
                                        BorderBrush="{StaticResource SilverMist}"
                                        BorderThickness="1"
                                        CornerRadius="14"
                                        Margin="0,4,0,0"
                                        MinWidth="{TemplateBinding ActualWidth}">
                                    <ScrollViewer MaxHeight="280">
                                        <StackPanel IsItemsHost="True" Margin="0,4"/>
                                    </ScrollViewer>
                                </Border>
                            </Popup>
                        </Grid>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style TargetType="TextBox">
            <Setter Property="Background"     Value="{StaticResource Fog}"/>
            <Setter Property="BorderBrush"    Value="{StaticResource SilverMist}"/>
            <Setter Property="Foreground"     Value="{StaticResource Ink}"/>
            <Setter Property="CaretBrush"     Value="{StaticResource Ink}"/>
            <Setter Property="SelectionBrush" Value="{StaticResource SilverMist}"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TextBox">
                        <Border x:Name="Chrome"
                                Background="{TemplateBinding Background}"
                                BorderBrush="{TemplateBinding BorderBrush}"
                                BorderThickness="{TemplateBinding BorderThickness}"
                                CornerRadius="14">
                            <ScrollViewer x:Name="PART_ContentHost"
                                          Margin="{TemplateBinding Padding}"
                                          VerticalAlignment="{TemplateBinding VerticalContentAlignment}"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsFocused" Value="True">
                                <Setter TargetName="Chrome" Property="BorderBrush" Value="{StaticResource Teal}"/>
                                <Setter TargetName="Chrome" Property="BorderThickness" Value="2"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- ================================================================
             Scrollbar - slim, brand-coloured
             ================================================================ -->
        <Style TargetType="ScrollBar">
            <Setter Property="Width"      Value="10"/>
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="ScrollBar">
                        <Grid Background="Transparent">
                            <Track x:Name="PART_Track" IsDirectionReversed="True">
                                <Track.Thumb>
                                    <Thumb>
                                        <Thumb.Template>
                                            <ControlTemplate TargetType="Thumb">
                                                <Border Background="{StaticResource Slate}"
                                                        CornerRadius="5"
                                                        Margin="3,0"/>
                                            </ControlTemplate>
                                        </Thumb.Template>
                                    </Thumb>
                                </Track.Thumb>
                            </Track>
                        </Grid>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

    </Window.Resources>

    <!-- ====================================================================
         Layout: header / tabs / activity log / status strip
         ==================================================================== -->
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <!-- Header -->
        <Border Grid.Row="0"
                Background="{StaticResource Snow}"
                BorderBrush="{StaticResource SilverMist}"
                BorderThickness="0,0,0,1">
            <!-- The official horizontal mark, never redrawn and never given an
                 effect. "Utility" sits beside it as the product name, in the
                 brand's Light headline weight. -->
            <StackPanel Orientation="Horizontal" Margin="24,10" VerticalAlignment="Center">
                <Image x:Name="MedProLogo"
                       Height="34"
                       Stretch="Uniform"
                       VerticalAlignment="Center"
                       RenderOptions.BitmapScalingMode="HighQuality"/>
                <Border Width="1" Height="26"
                        Background="{StaticResource SilverMist}"
                        Margin="16,0,16,0"
                        VerticalAlignment="Center"/>
                <TextBlock Text="Utility"
                           Style="{StaticResource Headline}"
                           FontSize="22"
                           VerticalAlignment="Center"/>
                <Border Background="{StaticResource Purple}"
                        CornerRadius="11"
                        Padding="10,3"
                        Margin="10,0,0,0"
                        VerticalAlignment="Center">
                    <TextBlock x:Name="MedProVersionLabel"
                               Text="v0.0.0"
                               FontSize="10.5"
                               FontWeight="SemiBold"
                               Foreground="{StaticResource Snow}"/>
                </Border>
                <TextBlock Text="Windows 11 provisioning, optimization, and debloat."
                           Style="{StaticResource Caption}"
                           Margin="16,0,0,0"
                           VerticalAlignment="Center"/>

                <!-- Presets tick boxes across every tab; they never execute anything. -->
                <TextBlock Text="P&#8202;R&#8202;E&#8202;S&#8202;E&#8202;T"
                           Style="{StaticResource CapsLabel}"
                           Margin="32,0,12,0"
                           VerticalAlignment="Center"/>
                <ComboBox x:Name="MedProPresetCombo"
                          Width="210"
                          Padding="12,6"
                          VerticalContentAlignment="Center"
                          VerticalAlignment="Center"/>
                <Button x:Name="MedProApplyPresetButton"
                        Style="{StaticResource GhostButton}"
                        Margin="8,0,0,0"
                        VerticalAlignment="Center"
                        Content="Select"/>
            </StackPanel>
        </Border>

        <!-- Tabs -->
        <TabControl x:Name="MedProTabControl" Grid.Row="1" Margin="24,2,24,0">

                    <TabItem Header="Install">
                        <Grid>
                            <Grid.RowDefinitions>
                                <RowDefinition Height="*"/>
                                <RowDefinition Height="Auto"/>
                            </Grid.RowDefinitions>

                            <ScrollViewer Grid.Row="0"
                                          VerticalScrollBarVisibility="Auto"
                                          HorizontalScrollBarVisibility="Disabled"
                                          Padding="0,12,12,0">
                                <!-- Filled at startup by Add-MedProInstallControls -->
                                <StackPanel x:Name="MedProInstallPanel" Margin="0,0,8,0"/>
                            </ScrollViewer>

                            <Border Grid.Row="1" Margin="0,8,8,10">
                                <StackPanel Orientation="Horizontal">
                                    <Button x:Name="MedProInstallButton"
                                            Style="{StaticResource PrimaryButton}"
                                            Content="Install selected"/>
                                    <Button x:Name="MedProSelectStandardAppsButton"
                                            Style="{StaticResource GhostButton}"
                                            Margin="12,0,0,0"
                                            Content="Select MedPro standard build"/>
                                    <Button x:Name="MedProClearInstallButton"
                                            Style="{StaticResource GhostButton}"
                                            Margin="4,0,0,0"
                                            Content="Clear"/>
                                </StackPanel>
                            </Border>
                        </Grid>
                    </TabItem>

                    <TabItem Header="Tweaks">
                        <Grid>
                            <Grid.RowDefinitions>
                                <RowDefinition Height="*"/>
                                <RowDefinition Height="Auto"/>
                            </Grid.RowDefinitions>

                            <ScrollViewer Grid.Row="0"
                                          VerticalScrollBarVisibility="Auto"
                                          HorizontalScrollBarVisibility="Disabled"
                                          Padding="0,12,12,0">
                                <!-- Filled at startup by Add-MedProTweakControls -->
                                <StackPanel x:Name="MedProTweaksPanel" Margin="0,0,8,0"/>
                            </ScrollViewer>

                            <Border Grid.Row="1" Margin="0,8,8,10">
                                <StackPanel Orientation="Horizontal">
                                    <Button x:Name="MedProApplyTweaksButton"
                                            Style="{StaticResource PrimaryButton}"
                                            Content="Apply selected tweaks"/>
                                    <Button x:Name="MedProUndoTweaksButton"
                                            Style="{StaticResource DarkPillButton}"
                                            Margin="12,0,0,0"
                                            Content="Undo selected"/>
                                    <Button x:Name="MedProSelectRecommendedButton"
                                            Style="{StaticResource GhostButton}"
                                            Margin="12,0,0,0"
                                            Content="Select MedPro recommended"/>
                                    <Button x:Name="MedProClearTweaksButton"
                                            Style="{StaticResource GhostButton}"
                                            Margin="4,0,0,0"
                                            Content="Clear"/>
                                </StackPanel>
                            </Border>
                        </Grid>
                    </TabItem>

                    <TabItem Header="Debloat">
                        <Grid>
                            <Grid.RowDefinitions>
                                <RowDefinition Height="*"/>
                                <RowDefinition Height="Auto"/>
                            </Grid.RowDefinitions>

                            <ScrollViewer Grid.Row="0"
                                          VerticalScrollBarVisibility="Auto"
                                          HorizontalScrollBarVisibility="Disabled"
                                          Padding="0,12,12,0">
                                <!-- Filled at startup by Add-MedProDebloatControls -->
                                <StackPanel x:Name="MedProDebloatPanel" Margin="0,0,8,0"/>
                            </ScrollViewer>

                            <Border Grid.Row="1" Margin="0,8,8,10">
                                <StackPanel Orientation="Horizontal">
                                    <Button x:Name="MedProRemoveAppsButton"
                                            Style="{StaticResource PrimaryButton}"
                                            Content="Remove selected apps"/>
                                    <Button x:Name="MedProSelectRecommendedAppsButton"
                                            Style="{StaticResource GhostButton}"
                                            Margin="12,0,0,0"
                                            Content="Select MedPro recommended"/>
                                    <Button x:Name="MedProClearAppsButton"
                                            Style="{StaticResource GhostButton}"
                                            Margin="4,0,0,0"
                                            Content="Clear"/>
                                </StackPanel>
                            </Border>
                        </Grid>
                    </TabItem>

                    <TabItem Header="Provisioning">
                        <ScrollViewer VerticalScrollBarVisibility="Auto"
                                      HorizontalScrollBarVisibility="Disabled"
                                      Padding="0,12,12,12">
                            <!-- Two columns rather than a stack: these three cards are
                                 short and independent, so side by side they fit the window
                                 without a scrollbar. -->
                            <Grid x:Name="MedProProvisioningPanel" Margin="0,0,8,0">
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="*"/>
                                </Grid.ColumnDefinitions>
                                <Grid.RowDefinitions>
                                    <RowDefinition Height="Auto"/>
                                    <RowDefinition Height="Auto"/>
                                </Grid.RowDefinitions>

                                <!-- Computer name -->
                                <Border Grid.Row="0" Grid.Column="0"
                                        Style="{StaticResource Card}" Margin="0,0,6,12">
                                    <StackPanel>
                                        <TextBlock Text="Computer name" Style="{StaticResource Heading}"/>
                                        <TextBlock x:Name="MedProNamingHint"
                                                   Style="{StaticResource Body}" Margin="0,8,0,0"
                                                   Text="Rename this machine to the MedPro naming standard."/>

                                        <Border Style="{StaticResource RecessedCard}" Margin="0,12,0,0">
                                            <StackPanel>
                                                <TextBlock Text="C&#8202;U&#8202;R&#8202;R&#8202;E&#8202;N&#8202;T&#8202; &#8202;N&#8202;A&#8202;M&#8202;E" Style="{StaticResource CapsLabel}"/>
                                                <TextBlock x:Name="MedProCurrentNameLabel"
                                                           Style="{StaticResource Subheading}"
                                                           Margin="0,4,0,0"
                                                           Text="-"/>
                                            </StackPanel>
                                        </Border>

                                        <StackPanel Orientation="Horizontal" Margin="0,12,0,0">
                                            <TextBox x:Name="MedProComputerNameBox"
                                                     Width="240"
                                                     Padding="11,7"
                                                     FontSize="13"
                                                     VerticalContentAlignment="Center"
                                                     Background="{StaticResource Fog}"
                                                     BorderBrush="{StaticResource SilverMist}"
                                                     BorderThickness="1"
                                                     Foreground="{StaticResource Ink}"/>
                                            <Button x:Name="MedProRenameButton"
                                                    Style="{StaticResource DarkPillButton}"
                                                    Margin="12,0,0,0"
                                                    Content="Rename"/>
                                        </StackPanel>
                                    </StackPanel>
                                </Border>

                                <!-- Domain join -->
                                <Border Grid.Row="0" Grid.Column="1"
                                        Style="{StaticResource Card}" Margin="6,0,0,12">
                                    <StackPanel>
                                        <TextBlock Text="Domain join" Style="{StaticResource Heading}"/>
                                        <TextBlock x:Name="MedProDomainHint"
                                                   Style="{StaticResource Body}" Margin="0,8,0,0"
                                                   Text="Join this machine to MedPro's directory."/>

                                        <Border Style="{StaticResource RecessedCard}" Margin="0,12,0,0">
                                            <StackPanel>
                                                <TextBlock Text="C&#8202;U&#8202;R&#8202;R&#8202;E&#8202;N&#8202;T&#8202; &#8202;J&#8202;O&#8202;I&#8202;N&#8202; &#8202;S&#8202;T&#8202;A&#8202;T&#8202;E" Style="{StaticResource CapsLabel}"/>
                                                <TextBlock x:Name="MedProJoinStateLabel"
                                                           Style="{StaticResource Subheading}"
                                                           Margin="0,4,0,0"
                                                           Text="-"/>
                                            </StackPanel>
                                        </Border>

                                        <TextBlock Style="{StaticResource Caption}" Margin="0,12,0,0"
                                                   Text="Credentials are entered in the Windows prompt and are never saved by this tool."/>

                                        <StackPanel Orientation="Horizontal" Margin="0,12,0,0">
                                            <Button x:Name="MedProJoinDomainButton"
                                                    Style="{StaticResource DarkPillButton}"
                                                    Content="Join Active Directory domain"/>
                                        </StackPanel>
                                    </StackPanel>
                                </Border>

                                <!-- Power -->
                                <Border Grid.Row="1" Grid.Column="0" Grid.ColumnSpan="2"
                                        Style="{StaticResource Card}" Margin="0,0,0,0">
                                    <StackPanel>
                                        <TextBlock Text="Power and screen lock" Style="{StaticResource Heading}"/>
                                        <TextBlock x:Name="MedProPowerHint"
                                                   Style="{StaticResource Body}" Margin="0,8,0,0"
                                                   Text="Apply MedPro's standard power plan and automatic screen lock."/>

                                        <StackPanel Orientation="Horizontal" Margin="0,12,0,0">
                                            <Button x:Name="MedProPowerProfileButton"
                                                    Style="{StaticResource PrimaryButton}"
                                                    Content="Apply MedPro power profile"/>
                                        </StackPanel>
                                    </StackPanel>
                                </Border>

                            </Grid>
                        </ScrollViewer>
                    </TabItem>

                    <TabItem Header="About">
                        <ScrollViewer VerticalScrollBarVisibility="Auto"
                                      HorizontalScrollBarVisibility="Disabled"
                                      Padding="0,12,12,12">
                            <!-- Prose is capped at the brand's content measure. A line of
                                 body copy running the full width of a 1600px window is
                                 not readable, however much room there is for it. -->
                            <StackPanel Margin="0,0,8,0" MaxWidth="1000" HorizontalAlignment="Left">
                                <Border Style="{StaticResource Card}">
                                    <StackPanel>
                                        <TextBlock Text="About MedPro Utility." Style="{StaticResource Headline}"/>
                                        <TextBlock Style="{StaticResource Body}" Margin="0,8,0,0"
                                                   Text="An internal MedPro Healthcare Staffing tool for standing up Windows 11 machines consistently: the standard app suite, the standard tweaks, and the standard provisioning steps, applied the same way every time and recorded in full."/>

                                        <TextBlock Text="Safety" Style="{StaticResource Subheading}" Margin="0,16,0,0"/>
                                        <TextBlock Style="{StaticResource Body}" Margin="0,8,0,0"
                                                   Text="A restore point is created before any tweak batch. Every tweak carries the original value needed to reverse it. Debloat is governed by a keep-list so business-critical software is never removed. Domain credentials are entered at run time and are never written to disk or to the log."/>

                                        <TextBlock Text="Credits" Style="{StaticResource Subheading}" Margin="0,16,0,0"/>
                                        <TextBlock Style="{StaticResource Body}" Margin="0,8,0,0"
                                                   Text="Architecture and a substantial portion of the tweak definitions are derived from WinUtil by Chris Titus Tech, used under the MIT License. See NOTICE.md in the repository."/>

                                        <StackPanel Orientation="Horizontal" Margin="0,16,0,0">
                                            <Button x:Name="MedProOpenLogButton"
                                                    Style="{StaticResource DarkPillButton}"
                                                    Content="Open log folder"/>
                                        </StackPanel>
                                    </StackPanel>
                                </Border>
                            </StackPanel>
                        </ScrollViewer>
                    </TabItem>

        </TabControl>

        <!-- ================================================================
             Activity log.

             A permanently open 150px log was the single biggest consumer of
             vertical space, so it is collapsed by default down to a one-line
             strip showing the most recent entry. The full pane opens on demand,
             and Set-MedProUIState opens it automatically while a task runs, so
             nothing is hidden at the moment it matters.
             ================================================================ -->
        <Border Grid.Row="2"
                Background="{StaticResource Snow}"
                BorderBrush="{StaticResource SilverMist}"
                BorderThickness="0,1,0,1"
                Padding="24,6">
            <Grid>
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="Auto"/>
                </Grid.RowDefinitions>

                <Grid Grid.Row="0">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="Auto"/>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="Auto"/>
                    </Grid.ColumnDefinitions>

                    <TextBlock Grid.Column="0" Text="A&#8202;C&#8202;T&#8202;I&#8202;V&#8202;I&#8202;T&#8202;Y"
                               Style="{StaticResource CapsLabel}" VerticalAlignment="Center"/>

                    <TextBlock x:Name="MedProLastLogLine"
                               Grid.Column="1"
                               Margin="14,0,14,0"
                               Text="Starting up..."
                               Style="{StaticResource Caption}"
                               FontFamily="Cascadia Mono, Consolas, Courier New"
                               TextTrimming="CharacterEllipsis"
                               VerticalAlignment="Center"/>

                    <Button x:Name="MedProToggleLogButton"
                            Grid.Column="2"
                            Style="{StaticResource GhostButton}"
                            Padding="12,4"
                            Content="Show full log"/>
                </Grid>

                <Border x:Name="MedProLogPanel"
                        Grid.Row="1"
                        Style="{StaticResource RecessedCard}"
                        Margin="0,6,0,4"
                        Padding="12"
                        Height="170"
                        Visibility="Collapsed">
                    <TextBox x:Name="MedProLogOutput"
                             Background="Transparent"
                             BorderThickness="0"
                             Foreground="{StaticResource Graphite}"
                             FontFamily="Cascadia Mono, Consolas, Courier New"
                             FontSize="12"
                             IsReadOnly="True"
                             IsReadOnlyCaretVisible="False"
                             TextWrapping="NoWrap"
                             VerticalScrollBarVisibility="Auto"
                             HorizontalScrollBarVisibility="Auto"/>
                </Border>
            </Grid>
        </Border>

        <!-- Status strip -->
        <Border Grid.Row="3" Background="{StaticResource Fog}" Padding="24,8">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="Auto"/>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>

                <TextBlock x:Name="MedProStatusLabel"
                           Grid.Column="0"
                           Text="Ready"
                           Style="{StaticResource Caption}"
                           FontWeight="SemiBold"
                           Foreground="{StaticResource Purple}"
                           VerticalAlignment="Center"/>

                <ProgressBar x:Name="MedProBusyBar"
                             Grid.Column="1"
                             Height="4"
                             Margin="20,0"
                             Background="{StaticResource PlumTint}"
                             Foreground="{StaticResource Teal}"
                             BorderThickness="0"
                             IsIndeterminate="False"
                             VerticalAlignment="Center"/>

                <TextBlock Grid.Column="2"
                           Text="MedPro Healthcare Staffing - Internal IT"
                           Style="{StaticResource Caption}"
                           VerticalAlignment="Center"/>
            </Grid>
        </Border>

    </Grid>
</Window>
'@
#endregion

#region Functions
#region private/Add-MedProBrandAssets.ps1
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
#endregion

#region private/Add-MedProCheckBoxCards.ps1
function Add-MedProCheckBoxCards {
    <#
    .SYNOPSIS
        Renders config entries into MedPro cards of checkboxes, grouped by category.

    .DESCRIPTION
        Shared by the Tweaks, Debloat, and Install tabs. Each of those is the same
        shape - a list of named, described, categorised things a technician ticks -
        so they share one renderer rather than three that drift apart.

        Categories appear in the order they first occur in the config, which makes
        the JSON file itself the source of truth for reading order.

        Every checkbox carries its config key in .Tag and is registered in the
        supplied control set, which is what Get-MedProSelection reads back.

    .PARAMETER Panel
        The StackPanel to fill. Cleared first.

    .PARAMETER Entries
        Output of Get-MedProConfigEntries: objects with .Name and .Value.

    .PARAMETER ControlSet
        Hashtable to populate with name-to-checkbox mappings.

    .PARAMETER MaxColumns
        Ceiling on how many checkbox columns a card may use. The actual count is
        whatever fits the window: the checkboxes live in a WrapPanel whose cell
        width is measured from the longest label in the config, so a wide window
        packs more columns and a narrow one reflows instead of clipping. That is
        what keeps a tab on one screen without a scrollbar.

    .OUTPUTS
        [int] Number of categories rendered.

    .EXAMPLE
        Add-MedProCheckBoxCards -Panel $sync.MedProTweaksPanel -Entries $entries -ControlSet $sync.TweakCheckBoxes
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]$Panel,

        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        $Entries,

        [Parameter(Mandatory)]
        [hashtable]$ControlSet,

        [int]$MaxColumns = 5
    )

    $Panel.Children.Clear()
    $ControlSet.Clear()

    if (@($Entries).Count -eq 0) { return 0 }

    $categories = New-Object System.Collections.Generic.List[string]
    foreach ($entry in $Entries) {
        $category = if ($entry.Value.category) { $entry.Value.category } else { "Other" }
        if (-not $categories.Contains($category)) { $categories.Add($category) }
    }

    $cautionBrush = $sync.Form.FindResource("Caution")

    # Every checkbox is built up front so the column width can be measured from
    # the real controls before any of them is placed. One width is used across
    # the whole tab, which keeps the cards on a single column grid rather than
    # letting each category drift to its own.
    foreach ($entry in $Entries) {
        $checkBox = New-Object System.Windows.Controls.CheckBox
        $checkBox.Content = if ($entry.Value.Content) { $entry.Value.Content } else { $entry.Value.content }
        $checkBox.Style   = $sync.Form.FindResource("MedProCheckBox")
        $checkBox.Tag     = $entry.Name

        if ($entry.Value.Description)     { $checkBox.ToolTip = $entry.Value.Description }
        elseif ($entry.Value.description) { $checkBox.ToolTip = $entry.Value.description }

        # Caution items are coloured rather than hidden: a technician should
        # see at a glance which choices carry weight.
        if ($entry.Value.caution -eq $true) { $checkBox.Foreground = $cautionBrush }

        $ControlSet[$entry.Name] = $checkBox
    }

    # The gutter is what stops two full-width labels sitting flush against each
    # other; the measurement itself already covers the tick box and its margin.
    $itemWidth = (Get-MedProLabelWidth -Controls $ControlSet.Values) + 18

    foreach ($category in $categories) {
        $inCategory = @($Entries | Where-Object {
            $c = if ($_.Value.category) { $_.Value.category } else { "Other" }
            $c -eq $category
        })

        $card  = New-Object System.Windows.Controls.Border
        $card.Style = $sync.Form.FindResource("Card")

        $stack = New-Object System.Windows.Controls.StackPanel
        $card.Child = $stack

        $heading = New-Object System.Windows.Controls.TextBlock
        $heading.Text  = $category
        $heading.Style = $sync.Form.FindResource("Heading")
        [void]$stack.Children.Add($heading)

        # A category note, taken from whichever entry in the group defines one.
        $note = ($inCategory | Where-Object { $_.Value.categoryNote } | Select-Object -First 1).Value.categoryNote
        if ($note) {
            $noteBlock = New-Object System.Windows.Controls.TextBlock
            $noteBlock.Text   = $note
            $noteBlock.Style  = $sync.Form.FindResource("Body")
            $noteBlock.Margin = New-Object System.Windows.Thickness(0, 6, 0, 0)
            [void]$stack.Children.Add($noteBlock)
        }

        # WrapPanel rather than UniformGrid: the column count follows the window
        # width instead of being fixed, so maximising actually buys density.
        $grid = New-Object System.Windows.Controls.WrapPanel
        $grid.Orientation = [System.Windows.Controls.Orientation]::Horizontal
        $grid.ItemWidth   = $itemWidth
        $grid.ItemHeight  = 25
        $grid.MaxWidth    = $itemWidth * $MaxColumns
        $grid.HorizontalAlignment = [System.Windows.HorizontalAlignment]::Left
        $grid.Margin      = New-Object System.Windows.Thickness(0, 8, 0, 0)
        [void]$stack.Children.Add($grid)

        foreach ($entry in $inCategory) {
            [void]$grid.Children.Add($ControlSet[$entry.Name])
        }

        [void]$Panel.Children.Add($card)
    }

    return $categories.Count
}
#endregion

#region private/Add-MedProDebloatControls.ps1
function Add-MedProDebloatControls {
    <#
    .SYNOPSIS
        Builds the Debloat tab from config/debloat.json.

    .DESCRIPTION
        Apps are grouped rather than listed one package at a time. A technician
        should be deciding "does this machine need Xbox", not ticking eight
        separate Xbox package names and hoping they got them all.

        The keep-list count is surfaced in the log at startup so it is obvious
        that a guard exists and roughly how much it covers.

    .EXAMPLE
        Add-MedProDebloatControls
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.MedProDebloatPanel) { return }

    $sync.DebloatCheckBoxes = @{}
    $entries = Get-MedProConfigEntries -Config $sync.configs.debloat.groups

    if ($entries.Count -eq 0) {
        Write-MedProLog "No debloat groups are defined in config/debloat.json." -Level Warning
        return
    }

    $categories = Add-MedProCheckBoxCards -Panel $sync.MedProDebloatPanel `
                                          -Entries $entries `
                                          -ControlSet $sync.DebloatCheckBoxes

    $keepCount = @($sync.configs.debloat.keepList).Count
    Write-MedProLog "Loaded $($entries.Count) debloat groups across $categories categories. $keepCount package patterns are protected by the keep-list."
}
#endregion

#region private/Add-MedProInstallControls.ps1
function Add-MedProInstallControls {
    <#
    .SYNOPSIS
        Builds the Install tab from config/applications.json.

    .DESCRIPTION
        One card per category, one checkbox per application. Adding software to
        the MedPro suite means editing one JSON file and rebuilding - no
        PowerShell required, which is the point.

        Entries with no winget fallback are worth knowing about, so the count is
        surfaced at startup: those are the ones where a dead vendor link means a
        failed install rather than a slightly different version.

    .EXAMPLE
        Add-MedProInstallControls
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.MedProInstallPanel) { return }

    $sync.InstallCheckBoxes = @{}
    $entries = Get-MedProConfigEntries -Config $sync.configs.applications

    if ($entries.Count -eq 0) {
        Write-MedProLog "No applications are defined in config/applications.json." -Level Warning
        return
    }

    $categories = Add-MedProCheckBoxCards -Panel $sync.MedProInstallPanel `
                                          -Entries $entries `
                                          -ControlSet $sync.InstallCheckBoxes

    $noFallback = @($entries | Where-Object { -not $_.Value.winget }).Count

    $message = "Loaded $($entries.Count) applications across $categories categories."
    if ($noFallback -gt 0) {
        $message += " $noFallback have no winget fallback and depend on their download link working."
    }
    Write-MedProLog $message
}
#endregion

#region private/Add-MedProPresetControls.ps1
function Add-MedProPresetControls {
    <#
    .SYNOPSIS
        Fills the preset dropdown in the header from config/preset.json.

    .DESCRIPTION
        Each item carries its config key in .Tag and its description in .ToolTip,
        so a technician can hover to see what a preset actually covers before
        choosing it.

    .EXAMPLE
        Add-MedProPresetControls
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.MedProPresetCombo) { return }

    $presets = Get-MedProConfigEntries -Config $sync.configs.preset
    $sync.MedProPresetCombo.Items.Clear()

    if ($presets.Count -eq 0) {
        $sync.MedProPresetCombo.IsEnabled = $false
        return
    }

    foreach ($preset in $presets) {
        $item = New-Object System.Windows.Controls.ComboBoxItem
        $item.Content = $preset.Value.content
        $item.Tag     = $preset.Name
        if ($preset.Value.description) { $item.ToolTip = $preset.Value.description }
        [void]$sync.MedProPresetCombo.Items.Add($item)
    }

    Write-MedProLog "Loaded $($presets.Count) presets."
}
#endregion

#region private/Add-MedProProvisioningControls.ps1
function Add-MedProProvisioningControls {
    <#
    .SYNOPSIS
        Fills in the Provisioning tab's live state and config-driven text.

    .DESCRIPTION
        Unlike the other tabs, the Provisioning layout is authored in the XAML -
        it needs a text box and distinct actions rather than a list of checkboxes.
        What this does is populate it with the current machine state and whatever
        MedPro has configured, so a technician can see what they are changing
        from before they change it.

        Where a config section is not filled in, the tab says so plainly instead
        of showing a button that will fail when pressed.

    .EXAMPLE
        Add-MedProProvisioningControls
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.MedProCurrentNameLabel) { return }

    $provisioning = $sync.configs.provisioning

    # --- Naming --------------------------------------------------------------
    # The box is pre-filled with the current name rather than a generated one:
    # the technician edits what is there, or leaves it alone.
    $sync.MedProCurrentNameLabel.Text = $env:COMPUTERNAME
    $sync.MedProComputerNameBox.Text  = $env:COMPUTERNAME

    $sync.MedProNamingHint.Text = "Edit the name below to rename this machine, or leave it as it is. " +
                                  "Up to 15 characters, letters, numbers, and hyphens. The change takes effect after a reboot."

    # --- Join state ----------------------------------------------------------
    # Read from the machine rather than assumed, so the tab is accurate on a
    # PC that was already partly provisioned by someone else.
    try {
        $computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction Stop
        $entraJoined = $false
        try {
            $entraJoined = ((& dsregcmd.exe /status 2>&1 | Out-String) -match 'AzureAdJoined\s*:\s*YES')
        } catch { }

        $sync.MedProJoinStateLabel.Text =
            if ($computerSystem.PartOfDomain -and $entraJoined) { "Hybrid joined - $($computerSystem.Domain) + Entra ID" }
            elseif ($computerSystem.PartOfDomain)               { "Domain joined - $($computerSystem.Domain)" }
            elseif ($entraJoined)                               { "Entra ID joined" }
            else                                               { "Workgroup - $($computerSystem.Workgroup)" }

    } catch {
        $sync.MedProJoinStateLabel.Text = "Could not be determined"
    }

    # --- Domain --------------------------------------------------------------
    $domain = $provisioning.domain
    if ($domain.configured -eq $true -and $domain.name) {
        $sync.MedProDomainHint.Text = "Joins this machine to $($domain.name)" +
            $(if ($domain.ouPath) { ", placing the computer object in $($domain.ouPath)." } else { "." })
    } else {
        $sync.MedProDomainHint.Text = "No domain is configured. Set 'name', 'ouPath', and 'configured': true in the domain " +
                                      "section of config/provisioning.json, then rebuild."
    }

    # --- Power ---------------------------------------------------------------
    if ($provisioning.power.description) {
        $sync.MedProPowerHint.Text = $provisioning.power.description
    }
}
#endregion

#region private/Add-MedProTweakControls.ps1
function Add-MedProTweakControls {
    <#
    .SYNOPSIS
        Builds the Tweaks tab from config/tweaks.json.

    .DESCRIPTION
        Nothing about the Tweaks tab is hard-coded in the XAML. Adding a tweak to
        the config and rebuilding is all it takes to make it appear here.

    .EXAMPLE
        Add-MedProTweakControls
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.MedProTweaksPanel) { return }

    $sync.TweakCheckBoxes = @{}
    $entries = Get-MedProConfigEntries -Config $sync.configs.tweaks

    if ($entries.Count -eq 0) {
        Write-MedProLog "No tweaks are defined in config/tweaks.json." -Level Warning
        return
    }

    $categories = Add-MedProCheckBoxCards -Panel $sync.MedProTweaksPanel `
                                          -Entries $entries `
                                          -ControlSet $sync.TweakCheckBoxes

    Write-MedProLog "Loaded $($entries.Count) tweaks across $categories categories."
}
#endregion

#region private/Connect-MedProShare.ps1
function Connect-MedProShare {
    <#
    .SYNOPSIS
        Makes sure the UNC shares an install run needs are reachable, prompting once.

    .DESCRIPTION
        A freshly imaged machine is often not domain joined yet, so \\med-dc-01\Install
        may refuse it. Rather than let those installs fail one by one, this checks
        access up front and prompts the technician once per share.

        Must be called on the UI thread. Get-Credential shows a dialog, and a
        dialog raised from a background runspace is one nobody ever sees - which
        is why this is a pre-flight step rather than something Get-MedProShareFile
        does for itself.

        The credential is used to map the share for the session and is not stored
        anywhere afterwards. Nothing is written to config, the repository, or the
        transcript.

    .PARAMETER Path
        One or more UNC paths that the run is about to need.

    .OUTPUTS
        Hashtable of share root to $true/$false accessibility.

    .EXAMPLE
        $access = Connect-MedProShare -Path @("\\med-dc-01\Install\Ricoh\setup.exe")
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        [AllowEmptyString()]
        [string[]]$Path
    )

    $access = @{}
    if (-not $sync.MappedShares) { $sync.MappedShares = New-Object System.Collections.Generic.List[string] }

    # Reduce a set of file paths to the distinct \\server\share roots behind them,
    # so two installers on one share only prompt once.
    $roots = @($Path |
        Where-Object { $_ -like "\\*" } |
        ForEach-Object { if ($_ -match '^(\\\\[^\\]+\\[^\\]+)') { $Matches[1] } } |
        Sort-Object -Unique)

    foreach ($root in $roots) {

        if (Test-Path -LiteralPath $root -ErrorAction SilentlyContinue) {
            Write-MedProLog "$root is reachable."
            $access[$root] = $true
            continue
        }

        Write-MedProLog "$root is not reachable with this machine's current credentials." -Level Warning

        $credential = Get-Credential -Message "Enter credentials with read access to $root"
        if (-not $credential) {
            Write-MedProLog "No credentials entered - applications on $root will be skipped." -Level Warning
            $access[$root] = $false
            continue
        }

        try {
            # A temporary, uniquely named PSDrive. Naming it after the share would
            # collide if the technician already has one mapped.
            $driveName = "MedProShare$($sync.MappedShares.Count)"

            New-PSDrive -Name $driveName -PSProvider FileSystem -Root $root `
                        -Credential $credential -Scope Global -ErrorAction Stop | Out-Null

            $sync.MappedShares.Add($driveName)

            # New-PSDrive succeeding authenticates the session to that server, so
            # the original UNC path works from here on without rewriting it.
            $access[$root] = [bool](Test-Path -LiteralPath $root -ErrorAction SilentlyContinue)

            if ($access[$root]) {
                Write-MedProLog "Connected to $root." -Level Success
            } else {
                Write-MedProLog "Mapped $root but still cannot read it." -Level Error
            }

        } catch {
            Write-MedProLog "Could not connect to $root - $($_.Exception.Message)" -Level Error
            $access[$root] = $false
        } finally {
            $credential = $null
        }
    }

    return $access
}
#endregion

#region private/Get-MedProConfigEntries.ps1
function Get-MedProConfigEntries {
    <#
    .SYNOPSIS
        Turns a config object from ConvertFrom-Json into an enumerable list.

    .DESCRIPTION
        ConvertFrom-Json produces a PSCustomObject whose keys are properties, not
        a hashtable, so the configs cannot be iterated directly. This flattens one
        into ordered Name/Value pairs and optionally filters by category, which is
        how every tab builds its control list.

    .PARAMETER Config
        A parsed config object, e.g. $sync.configs.tweaks.

    .PARAMETER Category
        Return only entries whose category matches. Case-insensitive.

    .EXAMPLE
        Get-MedProConfigEntries -Config $sync.configs.tweaks -Category "Essential Tweaks"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [AllowNull()]
        $Config,

        [string]$Category
    )

    if ($null -eq $Config) { return @() }

    $entries = foreach ($property in $Config.PSObject.Properties) {
        [PSCustomObject]@{
            Name  = $property.Name
            Value = $property.Value
        }
    }

    if ($PSBoundParameters.ContainsKey("Category")) {
        $entries = $entries | Where-Object { $_.Value.category -eq $Category }
    }

    # Wrapped so a single result still comes back as an array.
    return @($entries)
}
#endregion

#region private/Get-MedProDownload.ps1
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
#endregion

#region private/Get-MedProLabelWidth.ps1
function Get-MedProLabelWidth {
    <#
    .SYNOPSIS
        Measures the widest of a set of already-built controls, in device-independent pixels.

    .DESCRIPTION
        The checkbox tabs size their columns from their content rather than from
        a hard-coded number, so that adding a longer entry to config/*.json
        widens the column instead of quietly clipping the text or overlapping
        its neighbour.

        The measurement is taken from the real controls, with their real style
        applied, rather than from a character count or a bare TextBlock. Both of
        those under-read by enough to cause visible overlap, because they miss
        the tick box, its margin, and the font the template actually resolves.

        Measure() does not need the control to be in a visual tree, so this is
        safe to call before the window is shown.

    .PARAMETER Controls
        The controls that have to fit. Measured, not modified.

    .PARAMETER Minimum
        Floor for the result, so a tab of very short labels does not end up with
        comically narrow columns.

    .OUTPUTS
        [double] Width of the widest control.

    .EXAMPLE
        Get-MedProLabelWidth -Controls $checkBoxes
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        $Controls,

        [double]$Minimum = 160
    )

    $widest = $Minimum
    $unbounded = New-Object System.Windows.Size([double]::PositiveInfinity, [double]::PositiveInfinity)

    foreach ($control in $Controls) {
        if ($null -eq $control) { continue }
        try {
            $control.Measure($unbounded)
            if ($control.DesiredSize.Width -gt $widest) { $widest = $control.DesiredSize.Width }
        } catch {
            # A control that will not measure is not worth failing the whole tab
            # over. The remaining ones still set a sensible column width.
        }
    }

    return [Math]::Ceiling($widest)
}
#endregion

#region private/Get-MedProSelection.ps1
function Get-MedProSelection {
    <#
    .SYNOPSIS
        Returns the config keys of every ticked checkbox in a control set.

    .DESCRIPTION
        The bridge between the interface and the engines. Both the Tweaks tab and
        the Install tab keep their generated checkboxes in a name-to-control
        hashtable on $sync; this reads the ticked ones back out as plain strings.

        Reading IsChecked touches WPF objects, so the read is marshalled onto the
        dispatcher thread. That makes this safe to call from inside a runspace.

    .PARAMETER ControlSet
        The hashtable of checkboxes, e.g. $sync.TweakCheckBoxes.

    .OUTPUTS
        [string[]] Config keys, in the order the controls were created.

    .EXAMPLE
        $selected = Get-MedProSelection -ControlSet $sync.TweakCheckBoxes
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [AllowNull()]
        $ControlSet
    )

    if ($null -eq $ControlSet -or $ControlSet.Count -eq 0) { return @() }

    $selected = New-Object System.Collections.Generic.List[string]

    $read = {
        foreach ($key in $ControlSet.Keys) {
            if ($ControlSet[$key].IsChecked -eq $true) { $selected.Add($key) }
        }
    }.GetNewClosure()

    if ($sync.Form) {
        $sync.Form.Dispatcher.Invoke([action]$read, [System.Windows.Threading.DispatcherPriority]::Normal)
    } else {
        & $read
    }

    return @($selected)
}
#endregion

#region private/Get-MedProShareFile.ps1
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
#endregion

#region private/Install-MedProProgram.ps1
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
#endregion

#region private/Install-MedProWinget.ps1
function Install-MedProWinget {
    <#
    .SYNOPSIS
        Makes sure winget is available, installing App Installer if it is not.

    .DESCRIPTION
        winget is the fallback path for every application in the catalog, so it
        needs to work even on an image where it does not. Two cases are common:

          - A freshly imaged machine where App Installer has not yet been
            provisioned for the signed-in user. Re-registering the existing
            package fixes this without a download.
          - An LTSC or heavily stripped image with no App Installer at all,
            where the package and its dependencies have to be fetched.

        The result is cached on $sync for the session, because probing this on
        every application in a fifteen-app run is wasted time.

    .OUTPUTS
        [bool] Whether winget can be used.

    .EXAMPLE
        if (Install-MedProWinget) { winget install --id Google.Chrome }
    #>
    [CmdletBinding()]
    param()

    if ($null -ne $sync.WingetAvailable) { return $sync.WingetAvailable }

    if (Get-Command winget.exe -ErrorAction SilentlyContinue) {
        $sync.WingetAvailable = $true
        return $true
    }

    Write-MedProLog "winget was not found - trying to enable it..." -Level Warning

    # Cheapest fix first: the package is present but not registered for this user.
    try {
        $appInstaller = Get-AppxPackage -Name "Microsoft.DesktopAppInstaller" -ErrorAction SilentlyContinue
        if ($appInstaller) {
            Add-AppxPackage -DisableDevelopmentMode -Register `
                "$($appInstaller.InstallLocation)\AppXManifest.xml" -ErrorAction Stop
            if (Get-Command winget.exe -ErrorAction SilentlyContinue) {
                Write-MedProLog "winget re-registered." -Level Success
                $sync.WingetAvailable = $true
                return $true
            }
        }
    } catch {
        Write-MedProLog "  could not re-register App Installer - $($_.Exception.Message)" -Level Warning
    }

    # Otherwise fetch it. The two framework packages are dependencies App
    # Installer will not start without on a stripped image.
    $packages = @(
        @{ Name = "VCLibs.appx";      Url = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx" },
        @{ Name = "UIXaml.appx";      Url = "https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx" },
        @{ Name = "AppInstaller.msixbundle"; Url = "https://aka.ms/getwinget" }
    )

    foreach ($package in $packages) {
        $path = Get-MedProDownload -Url $package.Url -FileName $package.Name
        if (-not $path) {
            Write-MedProLog "Could not download $($package.Name). winget will not be available as a fallback." -Level Error
            $sync.WingetAvailable = $false
            return $false
        }

        try {
            Add-AppxPackage -Path $path -ErrorAction Stop
        } catch {
            # A dependency that is already present at a newer version reports a
            # failure here, which is not a problem worth stopping for.
            Write-MedProLog "  $($package.Name) - $($_.Exception.Message)" -Level Warning
        }
    }

    $available = [bool](Get-Command winget.exe -ErrorAction SilentlyContinue)
    if ($available) {
        Write-MedProLog "winget installed." -Level Success
    } else {
        Write-MedProLog "winget is still unavailable. Applications without a working download link will be skipped." -Level Error
    }

    $sync.WingetAvailable = $available
    return $available
}
#endregion

#region private/Invoke-MedProInstaller.ps1
function Invoke-MedProInstaller {
    <#
    .SYNOPSIS
        Runs a local installer file silently and returns its exit code.

    .DESCRIPTION
        The execution half of Install-MedProProgram, kept separate so that a
        file from a share and a file from a vendor URL run through exactly the
        same code once they are on disk.

        Throws if the installer cannot be started at all. Returns the exit code
        otherwise - deciding which codes mean success is the caller's job, because
        3010 and 1641 mean "worked, needs a reboot" rather than "failed".

    .PARAMETER InstallerPath
        Local path to the installer.

    .PARAMETER Type
        msi, msix, appx, or exe.

    .PARAMETER Arguments
        Silent-install switches. Falls back to a sensible default per type.

    .OUTPUTS
        [int] The installer's exit code.

    .EXAMPLE
        Invoke-MedProInstaller -InstallerPath $file -Type "msi" -Arguments "/qn /norestart"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$InstallerPath,
        [Parameter(Mandatory)][string]$Type,
        [AllowEmptyString()][string]$Arguments
    )

    switch ($Type.ToLower()) {

        "msi" {
            $switches = if ($Arguments) { $Arguments } else { "/qn /norestart" }
            # The path is quoted because MedPro's share paths contain spaces.
            $process = Start-Process -FilePath "msiexec.exe" `
                                     -ArgumentList "/i `"$InstallerPath`" $switches" `
                                     -Wait -PassThru -ErrorAction Stop
            return $process.ExitCode
        }

        { $_ -in @("msix", "appx", "msixbundle") } {
            Add-AppxProvisionedPackage -Online -PackagePath $InstallerPath -SkipLicense -ErrorAction Stop | Out-Null
            return 0
        }

        default {
            $switches = if ($Arguments) { $Arguments } else { "/S" }

            # Start-Process rejects an empty argument list, and a few installers
            # take no switches at all.
            if ([string]::IsNullOrWhiteSpace($switches)) {
                $process = Start-Process -FilePath $InstallerPath -Wait -PassThru -ErrorAction Stop
            } else {
                $process = Start-Process -FilePath $InstallerPath -ArgumentList $switches -Wait -PassThru -ErrorAction Stop
            }
            return $process.ExitCode
        }
    }
}
#endregion

#region private/Invoke-MedProRunspace.ps1
function Invoke-MedProRunspace {
    <#
    .SYNOPSIS
        Runs a block of work on a background thread so the window stays responsive.

    .DESCRIPTION
        Installing software and applying tweaks take minutes. Running them on the
        UI thread makes Windows paint the window white and offer to kill it, which
        is exactly the wrong prompt to show a technician mid-provision.

        This creates a runspace seeded with every MedPro function and the shared
        $sync hashtable, then runs the supplied work there. The UI is locked for
        the duration and unlocked in a finally block, so a crash inside the work
        cannot leave the interface permanently disabled.

        Only one task runs at a time. A second call while one is in flight is
        refused rather than queued.

    .PARAMETER ScriptBlock
        The work to run. It executes in a separate runspace, so it can only see
        $sync and the MedPro functions - not variables from the caller's scope.

    .PARAMETER ActivityName
        Shown in the status strip and used in the failure message.

    .EXAMPLE
        Invoke-MedProRunspace -ActivityName "Applying tweaks" -ScriptBlock {
            foreach ($tweak in $sync.SelectedTweaks) { Invoke-MedProTweak $tweak }
        }
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [scriptblock]$ScriptBlock,

        [string]$ActivityName = "Working"
    )

    if ($sync.ProcessRunning) {
        Write-MedProLog "'$ActivityName' was not started - another task is still running." -Level Warning
        return
    }

    $sync.ProcessRunning = $true
    Set-MedProUIState -Enabled $false -Status "$ActivityName..."

    # A fresh runspace starts empty, so every MedPro function has to be handed
    # over explicitly or the work block will fail on its first helper call.
    $sessionState = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
    foreach ($function in Get-ChildItem -Path Function:\ | Where-Object { $_.Name -like "*MedPro*" }) {
        $sessionState.Commands.Add(
            (New-Object System.Management.Automation.Runspaces.SessionStateFunctionEntry(
                $function.Name, $function.Definition))
        )
    }

    $runspace = [runspacefactory]::CreateRunspace($sessionState)
    $runspace.ApartmentState = "STA"
    $runspace.ThreadOptions  = "ReuseThread"
    $runspace.Open()
    $runspace.SessionStateProxy.SetVariable("sync", $sync)

    # Built as text rather than passed as an object: scriptblocks carry an
    # affinity to the runspace that created them, and reusing one across a
    # boundary silently marshals the work back onto the UI thread.
    $body = @"
`$ErrorActionPreference = 'Stop'
try {
$($ScriptBlock.ToString())
}
catch {
    Write-MedProLog "$ActivityName failed: `$(`$_.Exception.Message)" -Level Error
}
finally {
    `$sync.ProcessRunning = `$false
    Set-MedProUIState -Enabled `$true -Status "Ready"
}
"@

    $powershell = [powershell]::Create()
    $powershell.Runspace = $runspace
    $powershell.AddScript($body) | Out-Null

    $handle = $powershell.BeginInvoke()

    # Held so the closing handler can tear these down if the window is closed
    # while work is still in flight.
    $sync.Runspace   = $runspace
    $sync.PowerShell = $powershell

    # Disposal has to wait for the work to finish, and it must not block the UI
    # thread. A dispatcher timer polls the handle a few times a second, which is
    # cheap and keeps every object's lifetime tied to the window.
    $timer = New-Object System.Windows.Threading.DispatcherTimer
    $timer.Interval = [TimeSpan]::FromMilliseconds(500)
    $timer.Add_Tick({
        if (-not $handle.IsCompleted) { return }

        $timer.Stop()
        try { $powershell.EndInvoke($handle) } catch { }
        try { $powershell.Dispose() }         catch { }
        try { $runspace.Close(); $runspace.Dispose() } catch { }

        $sync.Runspace   = $null
        $sync.PowerShell = $null
    }.GetNewClosure())
    $timer.Start()
}
#endregion

#region private/Invoke-MedProScript.ps1
function Invoke-MedProScript {
    <#
    .SYNOPSIS
        Runs the InvokeScript / UndoScript blocks carried by a config entry.

    .DESCRIPTION
        Some changes cannot be expressed as a registry value - unregistering a
        scheduled task, calling powercfg, removing a shell extension. Those live
        in the config as script text and run through here.

        Each block is isolated: one failing block is logged and the rest still
        run, so a single unsupported operation cannot abandon a half-applied tweak.

    .PARAMETER Script
        One or more strings of PowerShell to execute, taken from the config entry.

    .PARAMETER Label
        Name of the owning tweak, used in log lines.

    .EXAMPLE
        Invoke-MedProScript -Script $tweak.InvokeScript -Label "Telemetry - Disable"
    #>
    [CmdletBinding()]
    param(
        [AllowNull()]
        [string[]]$Script,

        [string]$Label = "script"
    )

    if (-not $Script -or $Script.Count -eq 0) { return $true }

    $allSucceeded = $true

    foreach ($block in $Script) {
        if ([string]::IsNullOrWhiteSpace($block)) { continue }

        try {
            $scriptBlock = [scriptblock]::Create($block)
            & $scriptBlock
        } catch {
            Write-MedProLog "  script step failed in '$Label' - $($_.Exception.Message)" -Level Warning
            $allSucceeded = $false
        }
    }

    return $allSucceeded
}
#endregion

#region private/Invoke-MedProTweak.ps1
function Invoke-MedProTweak {
    <#
    .SYNOPSIS
        Applies or reverses a single tweak from config/tweaks.json.

    .DESCRIPTION
        Every tweak is described by up to three parts, all optional:

            registry      values to write, each carrying an OriginalValue
            service       startup types to change, each carrying an OriginalType
            Invoke/Undo   script blocks for anything the other two cannot express

        Apply walks registry -> service -> InvokeScript.
        Undo walks UndoScript -> registry (OriginalValue) -> service (OriginalType),
        script first because a shell extension usually has to be put back before
        the registry values that point at it mean anything.

        A tweak marked "action": true is a one-shot operation such as running
        Disk Cleanup. There is nothing to reverse, so Undo skips it rather than
        pretending it did something.

    .PARAMETER Name
        The config key, e.g. MedProTweaksTelemetry.

    .PARAMETER Tweak
        The parsed config entry.

    .PARAMETER Mode
        Apply or Undo.

    .OUTPUTS
        A result object with Name, Content, Mode, Success, and RestartRequired.

    .EXAMPLE
        Invoke-MedProTweak -Name "MedProTweaksTelemetry" -Tweak $entry -Mode Apply
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Name,
        [Parameter(Mandatory)]$Tweak,
        [ValidateSet("Apply", "Undo")][string]$Mode = "Apply"
    )

    $label = if ($Tweak.Content) { $Tweak.Content } else { $Name }

    if ($Mode -eq "Undo" -and $Tweak.action -eq $true) {
        Write-MedProLog "$label is a one-time action and cannot be undone - skipped." -Level Warning
        return [PSCustomObject]@{
            Name = $Name; Content = $label; Mode = $Mode
            Success = $true; Skipped = $true; RestartRequired = $false
        }
    }

    Write-MedProLog "$($Mode): $label"
    $success = $true

    # --- Undo runs its script first, before the registry it depends on moves ---
    if ($Mode -eq "Undo" -and $Tweak.UndoScript) {
        if (-not (Invoke-MedProScript -Script $Tweak.UndoScript -Label $label)) { $success = $false }
    }

    # --- Registry ---
    foreach ($entry in @($Tweak.registry)) {
        if ($null -eq $entry) { continue }

        $value = if ($Mode -eq "Apply") { $entry.Value } else { $entry.OriginalValue }

        # An undo entry with no OriginalValue is a config bug, not a runtime one.
        # Say so loudly rather than leaving the machine silently modified.
        if ($null -eq $value) {
            Write-MedProLog "  '$label' has no OriginalValue for $($entry.Path)\$($entry.Name) - cannot reverse it." -Level Error
            $success = $false
            continue
        }

        $type = if ($entry.Type) { $entry.Type } else { "DWord" }
        if (-not (Set-MedProRegistry -Path $entry.Path -Name $entry.Name -Type $type -Value $value)) {
            $success = $false
        }
    }

    # --- Services ---
    foreach ($entry in @($Tweak.service)) {
        if ($null -eq $entry) { continue }

        $startupType = if ($Mode -eq "Apply") { $entry.StartupType } else { $entry.OriginalType }
        if ($null -eq $startupType) {
            Write-MedProLog "  '$label' has no OriginalType for service $($entry.Name) - cannot reverse it." -Level Error
            $success = $false
            continue
        }

        if (-not (Set-MedProService -Name $entry.Name -StartupType $startupType)) { $success = $false }
    }

    # --- Apply runs its script last, once the registry is in its new state ---
    if ($Mode -eq "Apply" -and $Tweak.InvokeScript) {
        if (-not (Invoke-MedProScript -Script $Tweak.InvokeScript -Label $label)) { $success = $false }
    }

    if ($success) {
        Write-MedProLog "$label - done" -Level Success
    } else {
        Write-MedProLog "$label - finished with warnings" -Level Warning
    }

    return [PSCustomObject]@{
        Name            = $Name
        Content         = $label
        Mode            = $Mode
        Success         = $success
        Skipped         = $false
        RestartRequired = [bool]$Tweak.restartRequired
        RestartExplorer = [bool]$Tweak.restartExplorer
    }
}
#endregion

#region private/Join-MedProDomain.ps1
function Join-MedProDomain {
    <#
    .SYNOPSIS
        Joins the machine to the MedPro Active Directory domain.

    .DESCRIPTION
        Credentials are supplied by the technician at run time and are never
        written to the repository, the config, or the transcript. The credential
        object exists only for the lifetime of this call.

        The domain and OU come from config/provisioning.json. If that section is
        not configured the function refuses rather than prompting for a domain
        name, because a typo there creates a computer object in the wrong place
        that someone has to find and clean up later.

    .PARAMETER Credential
        An account with rights to join a machine to the domain.

    .OUTPUTS
        Result object with Success, Message, and RebootRequired.

    .EXAMPLE
        Join-MedProDomain -Credential (Get-Credential)
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [System.Management.Automation.PSCredential]$Credential
    )

    $domain = $sync.configs.provisioning.domain

    if ($domain.configured -ne $true -or [string]::IsNullOrWhiteSpace($domain.name)) {
        $message = "The domain section of config/provisioning.json is not configured. Set 'name', 'ouPath', and 'configured': true, then rebuild."
        Write-MedProLog $message -Level Error
        return [PSCustomObject]@{ Success = $false; Message = $message; RebootRequired = $false }
    }

    # Already joined? Re-joining a domain the machine is on is not harmless.
    $computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem
    if ($computerSystem.PartOfDomain -and $computerSystem.Domain -eq $domain.name) {
        $message = "This machine is already joined to $($domain.name)."
        Write-MedProLog $message -Level Success
        return [PSCustomObject]@{ Success = $true; Message = $message; RebootRequired = $false }
    }

    try {
        Write-MedProLog "Joining $($domain.name)..."

        $parameters = @{
            DomainName  = $domain.name
            Credential  = $Credential
            Force       = $true
            ErrorAction = "Stop"
        }
        if (-not [string]::IsNullOrWhiteSpace($domain.ouPath)) {
            $parameters.OUPath = $domain.ouPath
            Write-MedProLog "  target OU: $($domain.ouPath)"
        }

        Add-Computer @parameters

        Write-MedProLog "Joined $($domain.name). Reboot to complete the join." -Level Success
        return [PSCustomObject]@{
            Success = $true
            Message = "Joined $($domain.name). Reboot required."
            RebootRequired = $true
        }

    } catch {
        Write-MedProLog "Domain join failed: $($_.Exception.Message)" -Level Error
        return [PSCustomObject]@{ Success = $false; Message = $_.Exception.Message; RebootRequired = $false }
    }
}
#endregion

#region private/New-MedProRestorePoint.ps1
function New-MedProRestorePoint {
    <#
    .SYNOPSIS
        Creates a system restore point before the tool changes anything.

    .DESCRIPTION
        This is the safety net the whole Tweaks tab rests on. It runs before any
        batch of tweaks is applied, so a technician always has a way back even if
        an individual tweak's undo turns out to be incomplete.

        Two obstacles are handled:

        - System Protection is off by default on many OEM Windows 11 images, so
          it is enabled on the system drive first.
        - Windows silently refuses to create more than one restore point in a
          24-hour window. The frequency limit is lifted so a technician doing two
          runs on one machine still gets two checkpoints.

    .PARAMETER Description
        Label shown in the System Restore UI.

    .OUTPUTS
        [bool] Whether a restore point now exists for this run.

    .EXAMPLE
        New-MedProRestorePoint -Description "MedPro Utility - before tweaks"
    #>
    [CmdletBinding()]
    param(
        [string]$Description = "MedPro Utility"
    )

    Write-MedProLog "Creating a system restore point..."

    try {
        Enable-ComputerRestore -Drive "$env:SystemDrive\" -ErrorAction Stop
    } catch {
        Write-MedProLog "Could not enable System Protection: $($_.Exception.Message)" -Level Warning
    }

    # Without this, a second run in the same day silently produces no checkpoint.
    $frequencyKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore"
    $frequencyRestored = $false
    try {
        if (-not (Test-Path -LiteralPath $frequencyKey)) {
            New-Item -Path $frequencyKey -Force | Out-Null
        }
        Set-ItemProperty -LiteralPath $frequencyKey -Name "SystemRestorePointCreationFrequency" -Type DWord -Value 0 -Force
        $frequencyRestored = $true
    } catch {
        Write-MedProLog "Could not lift the restore point frequency limit: $($_.Exception.Message)" -Level Warning
    }

    try {
        $stamp = Get-Date -Format "yyyy-MM-dd HH:mm"
        Checkpoint-Computer -Description "$Description ($stamp)" -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
        Write-MedProLog "Restore point created." -Level Success
        $created = $true

    } catch {
        Write-MedProLog "Could not create a restore point: $($_.Exception.Message)" -Level Error
        Write-MedProLog "System Protection may be disabled by policy on this machine." -Level Warning
        $created = $false

    } finally {
        # Put the frequency limit back so this tool does not permanently change
        # how the machine behaves outside of a MedPro Utility run.
        if ($frequencyRestored) {
            Remove-ItemProperty -LiteralPath $frequencyKey -Name "SystemRestorePointCreationFrequency" -Force -ErrorAction SilentlyContinue
        }
    }

    return $created
}
#endregion

#region private/Remove-MedProAppx.ps1
function Remove-MedProAppx {
    <#
    .SYNOPSIS
        Removes an appx package for every user and deprovisions it for new profiles.

    .DESCRIPTION
        Removing a Store app properly takes two separate operations, and skipping
        either one is why debloat scripts appear not to work:

          Remove-AppxPackage -AllUsers      removes it from existing profiles
          Remove-AppxProvisionedPackage     stops Windows installing it into the
                                            next profile that signs in

        Patterns may contain wildcards, because package publisher prefixes and
        version suffixes vary between Windows builds and OEM images.

        The keep-list is enforced here rather than at the caller. Every resolved
        package name is checked against it before anything is removed, so a
        careless wildcard in the config cannot take out Windows Security, the
        Store, winget, or a framework package that other software depends on.

    .PARAMETER Pattern
        Package name patterns, e.g. "Microsoft.Xbox*" or "*CandyCrush*".

    .PARAMETER KeepList
        Patterns that must never be removed, regardless of what Pattern matches.

    .OUTPUTS
        A result object with Removed, Blocked, and Failed counts.

    .EXAMPLE
        Remove-MedProAppx -Pattern $group.packages -KeepList $sync.configs.debloat.keepList
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string[]]$Pattern,
        [string[]]$KeepList = @()
    )

    $removed = 0
    $blocked = 0
    $failed  = 0

    # Enumerated once rather than per pattern: Get-AppxPackage -AllUsers is slow
    # enough that calling it inside the loop is noticeable on a fresh image.
    #
    # Both -AllUsers and -Online require elevation. The tool gates on admin at
    # startup so this should never trip in normal use, but failing with a clear
    # sentence beats an UnauthorizedAccessException stack trace in the log.
    try {
        $installed   = @(Get-AppxPackage -AllUsers -ErrorAction Stop)
        $provisioned = @(Get-AppxProvisionedPackage -Online -ErrorAction Stop)
    } catch {
        Write-MedProLog "  cannot enumerate installed packages - $($_.Exception.Message)" -Level Error
        Write-MedProLog "  app removal needs an elevated session." -Level Error
        return [PSCustomObject]@{ Removed = 0; Blocked = 0; Failed = 1 }
    }

    foreach ($p in $Pattern) {
        if ([string]::IsNullOrWhiteSpace($p)) { continue }

        $matched = @($installed   | Where-Object { $_.Name -like $p }) +
                   @($provisioned | Where-Object { $_.DisplayName -like $p })

        if ($matched.Count -eq 0) { continue }

        $names = @($matched | ForEach-Object {
            if ($_.PSObject.Properties.Name -contains "DisplayName" -and $_.DisplayName) { $_.DisplayName } else { $_.Name }
        } | Sort-Object -Unique)

        foreach ($name in $names) {

            # The safety rail. A protected package is skipped and said out loud,
            # so an over-broad pattern shows up in the log rather than in a
            # support ticket a week later.
            $protectedBy = $KeepList | Where-Object { $name -like $_ } | Select-Object -First 1
            if ($protectedBy) {
                Write-MedProLog "  KEPT $name - protected by keep-list entry '$protectedBy'" -Level Warning
                $blocked++
                continue
            }

            $didSomething = $false

            foreach ($package in @($installed | Where-Object { $_.Name -eq $name })) {
                try {
                    Remove-AppxPackage -Package $package.PackageFullName -AllUsers -ErrorAction Stop
                    $didSomething = $true
                } catch {
                    Write-MedProLog "  could not remove $name for all users - $($_.Exception.Message)" -Level Warning
                    $failed++
                }
            }

            foreach ($package in @($provisioned | Where-Object { $_.DisplayName -eq $name })) {
                try {
                    Remove-AppxProvisionedPackage -Online -PackageName $package.PackageName -ErrorAction Stop | Out-Null
                    $didSomething = $true
                } catch {
                    Write-MedProLog "  could not deprovision $name - $($_.Exception.Message)" -Level Warning
                    $failed++
                }
            }

            if ($didSomething) {
                Write-MedProLog "  removed $name"
                $removed++
            }
        }
    }

    return [PSCustomObject]@{
        Removed = $removed
        Blocked = $blocked
        Failed  = $failed
    }
}
#endregion

#region private/Rename-MedProComputer.ps1
function Rename-MedProComputer {
    <#
    .SYNOPSIS
        Renames the machine, validating against the MedPro naming standard first.

    .DESCRIPTION
        The technician types whatever name the machine should have. MedPro has no
        naming pattern, so none is invented or enforced here - only Windows' own
        rules, which are real constraints rather than local policy:

          - the NetBIOS 15-character limit and its illegal characters, which
            Windows enforces but reports unhelpfully
          - a name that is all digits, which Windows rejects
          - whether the machine already has that name, which makes this a no-op
            rather than an unnecessary reboot

    .PARAMETER NewName
        The proposed computer name.

    .OUTPUTS
        Result object with Success, Message, and RebootRequired.

    .EXAMPLE
        Rename-MedProComputer -NewName "MP-MIA-0142"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$NewName
    )

    $NewName = $NewName.Trim()
    $fail = { param($Reason) [PSCustomObject]@{ Success = $false; Message = $Reason; RebootRequired = $false } }

    if ([string]::IsNullOrWhiteSpace($NewName)) {
        return & $fail "No name was entered."
    }

    # NetBIOS limits. Windows enforces these but reports them poorly.
    if ($NewName.Length -gt 15) {
        return & $fail "'$NewName' is $($NewName.Length) characters. Windows computer names are limited to 15."
    }
    if ($NewName -match '[^a-zA-Z0-9\-]') {
        return & $fail "'$NewName' contains characters that are not allowed. Use letters, numbers, and hyphens only."
    }
    if ($NewName -match '^\d+$') {
        return & $fail "'$NewName' is all digits, which Windows does not allow as a computer name."
    }

    if ($NewName -eq $env:COMPUTERNAME) {
        return [PSCustomObject]@{
            Success = $true
            Message = "This machine is already named $NewName - nothing to do."
            RebootRequired = $false
        }
    }

    try {
        Write-MedProLog "Renaming $env:COMPUTERNAME to $NewName..."
        Rename-Computer -NewName $NewName -Force -ErrorAction Stop

        Write-MedProLog "Renamed to $NewName. The change takes effect after a reboot." -Level Success
        return [PSCustomObject]@{
            Success = $true
            Message = "Renamed to $NewName. Reboot to apply."
            RebootRequired = $true
        }

    } catch {
        Write-MedProLog "Rename failed: $($_.Exception.Message)" -Level Error
        return & $fail $_.Exception.Message
    }
}
#endregion

#region private/Restart-MedProExplorer.ps1
function Restart-MedProExplorer {
    <#
    .SYNOPSIS
        Restarts Windows Explorer so shell tweaks take effect immediately.

    .DESCRIPTION
        Taskbar alignment, hidden files, file extensions, and the classic context
        menu all live in HKCU and are only read by explorer.exe at startup.
        Without this, a technician applies a tweak, sees nothing change, and
        applies it again.

        Explorer normally relaunches itself when killed. The wait-and-start below
        covers the case where it does not, which would otherwise leave the
        machine with no taskbar and no desktop.

    .EXAMPLE
        Restart-MedProExplorer
    #>
    [CmdletBinding()]
    param()

    Write-MedProLog "Restarting Windows Explorer so shell changes take effect..."

    try {
        Get-Process -Name explorer -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue

        # Windows usually respawns the shell on its own; give it a moment before
        # deciding it will not.
        Start-Sleep -Seconds 2

        if (-not (Get-Process -Name explorer -ErrorAction SilentlyContinue)) {
            Start-Process explorer.exe
            Start-Sleep -Seconds 1
        }

        Write-MedProLog "Explorer restarted." -Level Success

    } catch {
        Write-MedProLog "Explorer did not restart cleanly: $($_.Exception.Message)" -Level Warning
        Write-MedProLog "Sign out and back in if the taskbar looks wrong." -Level Warning
    }
}
#endregion

#region private/Set-MedProPowerProfile.ps1
function Set-MedProPowerProfile {
    <#
    .SYNOPSIS
        Applies the MedPro standard power plan and screen-lock policy.

    .DESCRIPTION
        Every value comes from config/provisioning.json, so changing MedPro's
        power policy is a config edit rather than a code change.

        The screen lock is the part that matters most here. On a machine that
        handles candidate and client records, an unattended unlocked desktop is
        the exposure - so the screensaver is enabled, made secure, and given a
        timeout, which is the mechanism Windows actually uses to auto-lock a
        session.

        Timeouts are applied to both AC and DC so the same profile is correct on
        a desktop and a laptop.

    .OUTPUTS
        [bool] Whether everything applied cleanly.

    .EXAMPLE
        Set-MedProPowerProfile
    #>
    [CmdletBinding()]
    param()

    $power = $sync.configs.provisioning.power
    if ($null -eq $power) {
        Write-MedProLog "No power section in config/provisioning.json." -Level Error
        return $false
    }

    $success = $true

    # --- Active plan ---------------------------------------------------------
    try {
        & powercfg.exe /setactive $power.planGuid 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) { throw "powercfg /setactive returned $LASTEXITCODE" }
        Write-MedProLog "  power plan set to $($power.planName)"
    } catch {
        Write-MedProLog "  could not set the power plan - $($_.Exception.Message)" -Level Warning
        $success = $false
    }

    # --- Timeouts ------------------------------------------------------------
    $timeouts = @(
        @{ Switch = "monitor-timeout-ac";   Value = $power.monitorTimeoutAC;   Label = "display off (mains)" },
        @{ Switch = "monitor-timeout-dc";   Value = $power.monitorTimeoutDC;   Label = "display off (battery)" },
        @{ Switch = "standby-timeout-ac";   Value = $power.standbyTimeoutAC;   Label = "sleep (mains)" },
        @{ Switch = "standby-timeout-dc";   Value = $power.standbyTimeoutDC;   Label = "sleep (battery)" },
        @{ Switch = "hibernate-timeout-ac"; Value = $power.hibernateTimeoutAC; Label = "hibernate (mains)" },
        @{ Switch = "hibernate-timeout-dc"; Value = $power.hibernateTimeoutDC; Label = "hibernate (battery)" }
    )

    foreach ($timeout in $timeouts) {
        if ($null -eq $timeout.Value) { continue }
        try {
            & powercfg.exe /change $timeout.Switch $timeout.Value 2>&1 | Out-Null
            if ($LASTEXITCODE -ne 0) { throw "powercfg returned $LASTEXITCODE" }
            $shown = if ($timeout.Value -eq 0) { "never" } else { "$($timeout.Value) min" }
            Write-MedProLog "  $($timeout.Label): $shown"
        } catch {
            Write-MedProLog "  could not set $($timeout.Label) - $($_.Exception.Message)" -Level Warning
            $success = $false
        }
    }

    # --- Lid behaviour -------------------------------------------------------
    # 0 = do nothing, 1 = sleep, 2 = hibernate, 3 = shut down. Skipped silently
    # on a desktop, where the setting exists but means nothing.
    $lidGuid = "5ca83367-6e45-459f-a27b-476b1d01c936"
    $subGuid = "4f971e89-eebd-4455-a8de-9e59040e7347"
    foreach ($lid in @(
        @{ Scope = "setacvalueindex"; Value = $power.lidActionAC; Label = "lid closed (mains)" },
        @{ Scope = "setdcvalueindex"; Value = $power.lidActionDC; Label = "lid closed (battery)" }
    )) {
        if ($null -eq $lid.Value) { continue }
        try {
            & powercfg.exe "/$($lid.Scope)" SCHEME_CURRENT $subGuid $lidGuid $lid.Value 2>&1 | Out-Null
            if ($LASTEXITCODE -eq 0) { Write-MedProLog "  $($lid.Label) set" }
        } catch {
            # Desktops have no lid. Not worth a warning.
        }
    }

    & powercfg.exe /setactive SCHEME_CURRENT 2>&1 | Out-Null

    # --- Screen lock ---------------------------------------------------------
    if ($power.screenLockMinutes) {
        $seconds = [int]$power.screenLockMinutes * 60
        $desktop = "HKCU:\Control Panel\Desktop"

        $locked = $true
        $locked = (Set-MedProRegistry -Path $desktop -Name "ScreenSaveActive"   -Type String -Value "1")       -and $locked
        $locked = (Set-MedProRegistry -Path $desktop -Name "ScreenSaverIsSecure" -Type String -Value "1")       -and $locked
        $locked = (Set-MedProRegistry -Path $desktop -Name "ScreenSaveTimeOut"   -Type String -Value "$seconds") -and $locked

        # A screensaver has to be set for the timeout to fire at all.
        $locked = (Set-MedProRegistry -Path $desktop -Name "SCRNSAVE.EXE" -Type String -Value "scrnsave.scr") -and $locked

        if ($locked) {
            Write-MedProLog "  screen locks after $($power.screenLockMinutes) minutes and requires a password"
        } else {
            $success = $false
        }
    }

    return $success
}
#endregion

#region private/Set-MedProRegistry.ps1
function Set-MedProRegistry {
    <#
    .SYNOPSIS
        Writes (or removes) a single registry value, creating the key if needed.

    .DESCRIPTION
        The write primitive every tweak goes through. Two behaviours matter:

        - Missing keys are created. Most policy keys under
          HKLM:\SOFTWARE\Policies do not exist on a stock Windows 11 install.

        - A value of "<RemoveEntry>" deletes the value instead of writing it.
          That is how a tweak is undone when the original state was "this value
          did not exist at all" - writing a zero back would not be the same thing.

        HKU: is mounted on demand, because Windows does not provide it as a
        PowerShell drive by default and several tweaks need the .DEFAULT hive.

    .PARAMETER Path
        Full registry path, e.g. HKLM:\SOFTWARE\Policies\Microsoft\Windows\System

    .PARAMETER Name
        Value name.

    .PARAMETER Type
        DWord, QWord, String, ExpandString, MultiString, or Binary.

    .PARAMETER Value
        The value to write, or the literal "<RemoveEntry>" to delete it.

    .EXAMPLE
        Set-MedProRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][string]$Name,
        [ValidateSet("DWord", "QWord", "String", "ExpandString", "MultiString", "Binary")]
        [string]$Type = "DWord",
        [Parameter(Mandatory)][AllowEmptyString()]$Value
    )

    if ($Path -like "HKU:*" -and -not (Get-PSDrive -Name HKU -ErrorAction SilentlyContinue)) {
        New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS -Scope Global | Out-Null
    }

    try {
        # Deleting rather than writing: this is how "the value was never there"
        # gets restored on undo.
        if ($Value -eq "<RemoveEntry>") {
            if (Test-Path -LiteralPath $Path) {
                Remove-ItemProperty -LiteralPath $Path -Name $Name -Force -ErrorAction SilentlyContinue
                Write-MedProLog "  removed $Path\$Name"
            }
            return $true
        }

        if (-not (Test-Path -LiteralPath $Path)) {
            New-Item -Path $Path -Force -ErrorAction Stop | Out-Null
            Write-MedProLog "  created key $Path"
        }

        # Binary values arrive from JSON as an array of numbers.
        $writeValue = if ($Type -eq "Binary" -and $Value -isnot [byte[]]) {
            [byte[]]@($Value | ForEach-Object { [byte]$_ })
        } else {
            $Value
        }

        Set-ItemProperty -LiteralPath $Path -Name $Name -Type $Type -Value $writeValue -Force -ErrorAction Stop
        Write-MedProLog "  set $Path\$Name = $Value"
        return $true

    } catch {
        Write-MedProLog "  could not set $Path\$Name - $($_.Exception.Message)" -Level Warning
        return $false
    }
}
#endregion

#region private/Set-MedProService.ps1
function Set-MedProService {
    <#
    .SYNOPSIS
        Changes a Windows service's startup type.

    .DESCRIPTION
        A service that is not present on this machine is not an error - Windows 11
        SKUs and feature states vary, and a missing service simply means the tweak
        has nothing to do here. Anything else is reported and the batch continues.

        Startup type is changed but running services are deliberately not stopped.
        Killing a service out from under a logged-in session is how a "performance
        tweak" turns into a support ticket; the new startup type takes effect on
        the next reboot, which is what the tool tells the technician to do anyway.

    .PARAMETER Name
        Service short name, e.g. "DiagTrack".

    .PARAMETER StartupType
        Automatic, AutomaticDelayedStart, Manual, or Disabled.

    .EXAMPLE
        Set-MedProService -Name "DiagTrack" -StartupType Disabled
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Name,

        [Parameter(Mandatory)]
        [ValidateSet("Automatic", "AutomaticDelayedStart", "Manual", "Disabled")]
        [string]$StartupType
    )

    $service = Get-Service -Name $Name -ErrorAction SilentlyContinue
    if (-not $service) {
        Write-MedProLog "  service '$Name' is not present on this machine - skipped."
        return $true
    }

    try {
        if ($StartupType -eq "AutomaticDelayedStart") {
            # Set-Service has no delayed-start option, so this drops to sc.exe.
            $result = & sc.exe config $Name start= delayed-auto 2>&1
            if ($LASTEXITCODE -ne 0) { throw "sc.exe returned $LASTEXITCODE - $result" }
        } else {
            Set-Service -Name $Name -StartupType $StartupType -ErrorAction Stop
        }

        Write-MedProLog "  service $Name -> $StartupType"
        return $true

    } catch {
        Write-MedProLog "  could not change service $Name - $($_.Exception.Message)" -Level Warning
        return $false
    }
}
#endregion

#region private/Set-MedProUIState.ps1
function Set-MedProUIState {
    <#
    .SYNOPSIS
        Enables or disables the interface while a long-running task is in flight.

    .DESCRIPTION
        Locks the tab area so a technician cannot start a second batch of tweaks
        on top of a running one, and updates the status strip so the window never
        looks frozen.

        Safe to call from a background runspace.

    .PARAMETER Enabled
        $false while work is running, $true when it finishes.

    .PARAMETER Status
        Text for the status strip. Omit to leave the current text alone.

    .EXAMPLE
        Set-MedProUIState -Enabled $false -Status "Applying tweaks..."
        Set-MedProUIState -Enabled $true  -Status "Ready"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [bool]$Enabled,

        [string]$Status
    )

    if ($null -eq $sync.Form) { return }

    $uiUpdate = {
        if ($sync.MedProTabControl) { $sync.MedProTabControl.IsEnabled = $Enabled }
        if ($sync.MedProBusyBar)    { $sync.MedProBusyBar.IsIndeterminate = (-not $Enabled) }

        if ($sync.MedProStatusLabel -and -not [string]::IsNullOrWhiteSpace($Status)) {
            $sync.MedProStatusLabel.Text = $Status
        }

        # The log pane is collapsed by default to keep a tab on one screen, but
        # a run in flight is exactly when a technician wants to watch it, so it
        # opens itself here. It is left open afterwards - closing it under
        # someone mid-read would be worse than the space it costs.
        if (-not $Enabled -and $sync.MedProLogPanel -and
            $sync.MedProLogPanel.Visibility -ne [System.Windows.Visibility]::Visible) {
            $sync.MedProLogPanel.Visibility = [System.Windows.Visibility]::Visible
            if ($sync.MedProToggleLogButton) { $sync.MedProToggleLogButton.Content = "Hide full log" }
        }
    }.GetNewClosure()

    try {
        $sync.Form.Dispatcher.Invoke([action]$uiUpdate, [System.Windows.Threading.DispatcherPriority]::Normal)
    } catch {
        # Window gone. Nothing to update.
    }
}
#endregion

#region private/Test-MedProInstalled.ps1
function Test-MedProInstalled {
    <#
    .SYNOPSIS
        Checks whether an application is already present, using its detect rule.

    .DESCRIPTION
        Re-running the installer for software that is already there wastes a
        technician's time and, for some vendors, downgrades a newer version to
        whatever the catalog link points at.

        A detect rule is either a registry path or a file path. Environment
        variables in it are expanded, so a catalog entry can say
        "%ProgramFiles%\Vendor\app.exe" without knowing the drive layout.

    .PARAMETER Detect
        Registry path (HKLM:\..., HKCU:\...) or a file system path.

    .OUTPUTS
        [bool] True if the application appears to be installed.

    .EXAMPLE
        Test-MedProInstalled -Detect "HKLM:\SOFTWARE\Google\Chrome"
        Test-MedProInstalled -Detect "%ProgramFiles%\7-Zip\7z.exe"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]$Detect
    )

    if ([string]::IsNullOrWhiteSpace($Detect)) { return $false }

    $expanded = [System.Environment]::ExpandEnvironmentVariables($Detect)

    try {
        return [bool](Test-Path -Path $expanded -ErrorAction SilentlyContinue)
    } catch {
        return $false
    }
}
#endregion

#region private/Write-MedProLog.ps1
function Write-MedProLog {
    <#
    .SYNOPSIS
        Writes a timestamped line to the on-screen log, the console, and the transcript.

    .DESCRIPTION
        This is the only logging path in MedPro Utility. Everything the tool does
        to a machine goes through here, so the transcript in
        %ProgramData%\MedProUtility\logs is a complete account of the session.

        Safe to call from a background runspace: UI updates are marshalled back
        to the window's dispatcher thread.

    .PARAMETER Message
        The line to record.

    .PARAMETER Level
        Info, Success, Warning, or Error. Controls console colour and the prefix
        shown in the on-screen log.

    .EXAMPLE
        Write-MedProLog "Disabling telemetry" -Level Info
        Write-MedProLog "Chrome installed" -Level Success
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [AllowEmptyString()]
        [string]$Message,

        [ValidateSet("Info", "Success", "Warning", "Error")]
        [string]$Level = "Info"
    )

    $prefix = switch ($Level) {
        "Success" { "  OK  " }
        "Warning" { " WARN " }
        "Error"   { " FAIL " }
        default   { "      " }
    }

    $colour = switch ($Level) {
        "Success" { "Green" }
        "Warning" { "Yellow" }
        "Error"   { "Red" }
        default   { "Gray" }
    }

    $line = "[{0}]{1} {2}" -f (Get-Date -Format "HH:mm:ss"), $prefix, $Message

    # Console write is what the transcript captures.
    Write-Host $line -ForegroundColor $colour

    if ($null -eq $sync.Form -or $null -eq $sync.MedProLogOutput) { return }

    $uiUpdate = {
        $sync.MedProLogOutput.AppendText($line + [Environment]::NewLine)
        $sync.MedProLogOutput.ScrollToEnd()

        # The full log is collapsed by default, so the newest line is mirrored
        # into the always-visible strip above it. Nothing is ever the only copy:
        # the pane, the console, and the transcript all still have it.
        if ($sync.MedProLastLogLine) { $sync.MedProLastLogLine.Text = $line }
    }.GetNewClosure()

    try {
        $sync.Form.Dispatcher.Invoke([action]$uiUpdate, [System.Windows.Threading.DispatcherPriority]::Normal)
    } catch {
        # The window is closing or already gone. The console and transcript
        # already have the line, so there is nothing worth reporting here.
    }
}
#endregion

#region public/Invoke-MedProApplyPresetButton.ps1
function Invoke-MedProApplyPresetButton {
    <#
    .SYNOPSIS
        Ticks everything a preset covers across the Install, Tweaks, and Debloat tabs.

    .DESCRIPTION
        Bound to MedProApplyPresetButton.

        A preset selects; it does not execute. The technician still reviews each
        tab and presses its own action button. That is deliberate - installing
        software, changing system settings, and permanently removing apps should
        not all happen from one click on a dropdown, and a technician who cannot
        see what a preset chose cannot catch the case where it is wrong for the
        machine in front of them.

        A preset naming a key that no longer exists in the configs is reported
        rather than skipped, because that means the preset has drifted out of
        date and will quietly under-provision every machine it touches.
    #>
    [CmdletBinding()]
    param()

    $selected = $sync.MedProPresetCombo.SelectedItem
    if (-not $selected) {
        Write-MedProLog "Choose a preset first." -Level Warning
        return
    }

    # The key travels on the item's Tag so the display name can change freely.
    $presetKey = $selected.Tag
    $preset    = $sync.configs.preset.$presetKey

    if (-not $preset) {
        Write-MedProLog "Preset '$presetKey' is missing from config/preset.json." -Level Error
        return
    }

    Write-MedProLog "Applying preset: $($preset.content)"

    $stale = New-Object System.Collections.Generic.List[string]

    $targets = @(
        @{ Keys = @($preset.applications); Controls = $sync.InstallCheckBoxes; Label = "applications" },
        @{ Keys = @($preset.tweaks);       Controls = $sync.TweakCheckBoxes;   Label = "tweaks" },
        @{ Keys = @($preset.debloat);      Controls = $sync.DebloatCheckBoxes; Label = "app groups to remove" }
    )

    foreach ($target in $targets) {
        if (-not $target.Controls) { continue }

        # Clear first so switching presets replaces the selection rather than
        # accumulating on top of whatever was ticked before.
        foreach ($name in $target.Controls.Keys) { $target.Controls[$name].IsChecked = $false }

        $ticked = 0
        foreach ($key in $target.Keys) {
            if ($target.Controls.ContainsKey($key)) {
                $target.Controls[$key].IsChecked = $true
                $ticked++
            } else {
                $stale.Add("$key (in $($target.Label))")
            }
        }

        Write-MedProLog "  $ticked $($target.Label) selected"
    }

    foreach ($missing in $stale) {
        Write-MedProLog "  preset refers to '$missing', which no longer exists in the configs." -Level Warning
    }

    Write-MedProLog "Review each tab, then use its own button to apply. Nothing has been changed yet." -Level Success
}
#endregion

#region public/Invoke-MedProApplyTweaksButton.ps1
function Invoke-MedProApplyTweaksButton {
    <#
    .SYNOPSIS
        Applies every ticked tweak, after taking a restore point.

    .DESCRIPTION
        Bound to MedProApplyTweaksButton. Confirms the selection, then hands the
        batch to a background runspace so the window stays responsive.

        The restore point comes first and its failure is surfaced as a decision
        rather than a log line: applying a batch of registry and service changes
        with no way back is a choice a technician should make deliberately.
    #>
    [CmdletBinding()]
    param()

    $selected = Get-MedProSelection -ControlSet $sync.TweakCheckBoxes

    if ($selected.Count -eq 0) {
        Write-MedProLog "Nothing selected - tick the tweaks you want to apply." -Level Warning
        return
    }

    $cautionCount = @($selected | Where-Object { $sync.configs.tweaks.$_.caution -eq $true }).Count

    $message = "Apply $($selected.Count) tweak$(if ($selected.Count -ne 1) { 's' }) to this machine?"
    if ($cautionCount -gt 0) {
        $message += "`n`n$cautionCount of them are marked caution and change how Windows behaves in ways users will notice."
    }
    $message += "`n`nA system restore point will be created first."

    $answer = [System.Windows.MessageBox]::Show(
        $message, "MedPro Utility",
        [System.Windows.MessageBoxButton]::OKCancel,
        [System.Windows.MessageBoxImage]::Question)

    if ($answer -ne [System.Windows.MessageBoxResult]::OK) {
        Write-MedProLog "Cancelled - nothing was changed."
        return
    }

    # The runspace runs in its own scope and cannot see local variables, so the
    # work list travels across on $sync.
    $sync.PendingTweaks = $selected

    Invoke-MedProRunspace -ActivityName "Applying tweaks" -ScriptBlock {

        Write-MedProLog "----- Applying $($sync.PendingTweaks.Count) tweaks -----"

        if (-not (New-MedProRestorePoint -Description "MedPro Utility - before tweaks")) {
            Write-MedProLog "No restore point was created. Continuing, but there is no automatic way back." -Level Warning
        }

        $results = foreach ($name in $sync.PendingTweaks) {
            $tweak = $sync.configs.tweaks.$name
            if ($null -eq $tweak) {
                Write-MedProLog "'$name' is selected but missing from the config - skipped." -Level Error
                continue
            }
            Invoke-MedProTweak -Name $name -Tweak $tweak -Mode Apply
        }

        $results = @($results)
        $failed  = @($results | Where-Object { -not $_.Success })

        Write-MedProLog "----- $($results.Count - $failed.Count) of $($results.Count) applied cleanly -----" -Level $(if ($failed.Count) { "Warning" } else { "Success" })

        foreach ($failure in $failed) {
            Write-MedProLog "Review: $($failure.Content)" -Level Warning
        }

        if (@($results | Where-Object { $_.RestartExplorer }).Count -gt 0) {
            Restart-MedProExplorer
        }

        if (@($results | Where-Object { $_.RestartRequired }).Count -gt 0) {
            Write-MedProLog "A reboot is required before some of these changes take effect." -Level Warning
        }
    }
}
#endregion

#region public/Invoke-MedProClearAppsButton.ps1
function Invoke-MedProClearAppsButton {
    <#
    .SYNOPSIS
        Unticks every app group on the Debloat tab.

    .DESCRIPTION
        Bound to MedProClearAppsButton. Given what the Remove button does, an
        obvious way to abandon a half-made selection is worth having.
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.DebloatCheckBoxes) { return }

    foreach ($name in $sync.DebloatCheckBoxes.Keys) {
        $sync.DebloatCheckBoxes[$name].IsChecked = $false
    }

    Write-MedProLog "App selection cleared."
}
#endregion

#region public/Invoke-MedProClearInstallButton.ps1
function Invoke-MedProClearInstallButton {
    <#
    .SYNOPSIS
        Unticks every application on the Install tab.

    .DESCRIPTION
        Bound to MedProClearInstallButton.
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.InstallCheckBoxes) { return }

    foreach ($name in $sync.InstallCheckBoxes.Keys) {
        $sync.InstallCheckBoxes[$name].IsChecked = $false
    }

    Write-MedProLog "Application selection cleared."
}
#endregion

#region public/Invoke-MedProClearTweaksButton.ps1
function Invoke-MedProClearTweaksButton {
    <#
    .SYNOPSIS
        Unticks every tweak checkbox.

    .DESCRIPTION
        Bound to MedProClearTweaksButton. Clearing the selection is the fastest
        way out of a half-made choice, and it costs nothing to offer.
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.TweakCheckBoxes) { return }

    foreach ($name in $sync.TweakCheckBoxes.Keys) {
        $sync.TweakCheckBoxes[$name].IsChecked = $false
    }

    Write-MedProLog "Selection cleared."
}
#endregion

#region public/Invoke-MedProInstallButton.ps1
function Invoke-MedProInstallButton {
    <#
    .SYNOPSIS
        Installs every ticked application from the MedPro catalog.

    .DESCRIPTION
        Bound to MedProInstallButton. Runs the batch in a background runspace and
        reports per-application outcomes honestly at the end.

        The summary distinguishes installs that came from the vendor link from
        those that fell back to winget. A run where everything quietly came from
        winget means the catalog's links have rotted, and that should be visible
        in the log rather than discovered months later.
    #>
    [CmdletBinding()]
    param()

    $selected = Get-MedProSelection -ControlSet $sync.InstallCheckBoxes

    if ($selected.Count -eq 0) {
        Write-MedProLog "Nothing selected - tick the applications you want installed." -Level Warning
        return
    }

    # --- Share access, checked before the runspace starts --------------------
    # Get-Credential raises a dialog, and a dialog raised from a background
    # runspace is one nobody ever sees. So the shares are sorted out here, on
    # the UI thread, while a prompt can still reach the technician.
    $sharePaths = @($selected |
        ForEach-Object { $sync.configs.applications.$_.path } |
        Where-Object { $_ })

    if ($sharePaths.Count -gt 0) {
        $access = Connect-MedProShare -Path $sharePaths

        $unreachable = @($access.Keys | Where-Object { -not $access[$_] })
        if ($unreachable.Count -gt 0) {
            $blocked = @($selected | Where-Object {
                $path = $sync.configs.applications.$_.path
                $path -and ($unreachable | Where-Object { $path -like "$_*" })
            })

            $names = ($blocked | ForEach-Object { "  - $($sync.configs.applications.$_.content)" }) -join "`n"
            $answer = [System.Windows.MessageBox]::Show(
                "These applications are on a share this machine cannot reach:`n`n$names`n`nContinue without them?",
                "MedPro Utility",
                [System.Windows.MessageBoxButton]::OKCancel,
                [System.Windows.MessageBoxImage]::Warning)

            if ($answer -ne [System.Windows.MessageBoxResult]::OK) {
                Write-MedProLog "Cancelled - nothing was installed."
                return
            }

            foreach ($name in $blocked) {
                Write-MedProLog "Skipping $($sync.configs.applications.$name.content) - its share is unreachable." -Level Warning
            }
            $selected = @($selected | Where-Object { $blocked -notcontains $_ })

            if ($selected.Count -eq 0) {
                Write-MedProLog "Nothing left to install." -Level Warning
                return
            }
        }
    }

    # --- Warn about anything that will not install silently -------------------
    # Better to know a "walk away" run needs a human before starting it than to
    # come back twenty minutes later to a dialog waiting for a click.
    $interactive = @($selected | Where-Object { $sync.configs.applications.$_.interactive -eq $true })
    if ($interactive.Count -gt 0) {
        $names = ($interactive | ForEach-Object { "  - $($sync.configs.applications.$_.content)" }) -join "`n"
        Write-MedProLog "$($interactive.Count) of these will not install silently and need a technician at the machine:" -Level Warning
        foreach ($name in $interactive) {
            Write-MedProLog "  $($sync.configs.applications.$name.content)" -Level Warning
        }

        [System.Windows.MessageBox]::Show(
            "These do not install silently and will show their own installer:`n`n$names`n`nStay at the machine to click through them.",
            "MedPro Utility",
            [System.Windows.MessageBoxButton]::OK,
            [System.Windows.MessageBoxImage]::Information) | Out-Null
    }

    $sync.PendingInstalls = $selected

    Invoke-MedProRunspace -ActivityName "Installing applications" -ScriptBlock {

        $total = $sync.PendingInstalls.Count
        Write-MedProLog "----- Installing $total applications -----"

        $results = New-Object System.Collections.Generic.List[object]
        $index = 0

        foreach ($name in $sync.PendingInstalls) {
            $index++

            $app = $sync.configs.applications.$name
            if ($null -eq $app) {
                Write-MedProLog "'$name' is selected but missing from the catalog - skipped." -Level Error
                continue
            }

            Set-MedProUIState -Enabled $false -Status "Installing $index of $total - $($app.content)"
            $results.Add((Install-MedProProgram -Name $name -App $app))
        }

        # --- Summary ---------------------------------------------------------
        $installed = @($results | Where-Object { $_.Status -eq "Installed" })
        $present   = @($results | Where-Object { $_.Status -eq "AlreadyPresent" })
        $failed    = @($results | Where-Object { $_.Status -eq "Failed" })
        $viaWinget = @($installed | Where-Object { $_.Source -eq "winget" })

        Write-MedProLog "----- $($installed.Count) installed, $($present.Count) already present, $($failed.Count) failed -----" `
            -Level $(if ($failed.Count) { "Warning" } else { "Success" })

        foreach ($failure in $failed) {
            Write-MedProLog "Failed: $($failure.Content)" -Level Error
        }

        if ($viaWinget.Count -gt 0) {
            Write-MedProLog "$($viaWinget.Count) application(s) fell back to winget. Check their links in config/applications.json:" -Level Warning
            foreach ($fallback in $viaWinget) {
                Write-MedProLog "  $($fallback.Content)" -Level Warning
            }
        }

        if (@($results | Where-Object { $_.RebootRequired }).Count -gt 0) {
            Write-MedProLog "A reboot is needed to finish one or more installs." -Level Warning
        }
    }
}
#endregion

#region public/Invoke-MedProJoinDomainButton.ps1
function Invoke-MedProJoinDomainButton {
    <#
    .SYNOPSIS
        Joins this machine to the MedPro domain, prompting for credentials.

    .DESCRIPTION
        Bound to MedProJoinDomainButton.

        Get-Credential shows Windows' own secure prompt. The technician types the
        credentials into that dialog; the resulting object is held only for the
        duration of the join and cleared immediately afterwards. Nothing is
        written to the config, the repository, or the transcript.
    #>
    [CmdletBinding()]
    param()

    $domain = $sync.configs.provisioning.domain

    if ($domain.configured -ne $true -or [string]::IsNullOrWhiteSpace($domain.name)) {
        [System.Windows.MessageBox]::Show(
            "The domain is not configured yet.`n`nSet 'name', 'ouPath', and 'configured': true in the domain section of config/provisioning.json, then rebuild with .\Compile.ps1.",
            "MedPro Utility",
            [System.Windows.MessageBoxButton]::OK,
            [System.Windows.MessageBoxImage]::Information) | Out-Null
        Write-MedProLog "Domain join skipped - config/provisioning.json has no domain configured." -Level Warning
        return
    }

    $credential = Get-Credential -Message "Enter an account with rights to join $($domain.name)."
    if (-not $credential) {
        Write-MedProLog "Domain join cancelled - no credentials entered."
        return
    }

    try {
        Set-MedProUIState -Enabled $false -Status "Joining $($domain.name)..."
        $result = Join-MedProDomain -Credential $credential
    } finally {
        # The credential object goes out of scope here and is not stored anywhere.
        $credential = $null
        [System.GC]::Collect()
        Set-MedProUIState -Enabled $true -Status "Ready"
    }

    if ($result.RebootRequired) { $sync.RebootPending = $true }

    $icon = if ($result.Success) {
        [System.Windows.MessageBoxImage]::Information
    } else {
        [System.Windows.MessageBoxImage]::Warning
    }

    [System.Windows.MessageBox]::Show(
        $result.Message, "MedPro Utility",
        [System.Windows.MessageBoxButton]::OK, $icon) | Out-Null
}
#endregion

#region public/Invoke-MedProOpenLogButton.ps1
function Invoke-MedProOpenLogButton {
    <#
    .SYNOPSIS
        Opens the folder holding this session's transcript in File Explorer.

    .DESCRIPTION
        Bound automatically to the control named MedProOpenLogButton. Every run
        of this tool writes a full transcript; this is the shortest path from
        "what did it just do to this machine" to the answer.
    #>
    [CmdletBinding()]
    param()

    if (-not (Test-Path -LiteralPath $sync.logPath)) {
        Write-MedProLog "Log folder $($sync.logPath) does not exist yet." -Level Warning
        return
    }

    # Selecting the current session's file saves scrolling a folder full of runs.
    if ($sync.logFile -and (Test-Path -LiteralPath $sync.logFile)) {
        Start-Process explorer.exe -ArgumentList "/select,`"$($sync.logFile)`""
    } else {
        Start-Process explorer.exe -ArgumentList "`"$($sync.logPath)`""
    }

    Write-MedProLog "Opened $($sync.logPath)"
}
#endregion

#region public/Invoke-MedProPowerProfileButton.ps1
function Invoke-MedProPowerProfileButton {
    <#
    .SYNOPSIS
        Applies the MedPro standard power plan and screen-lock policy.

    .DESCRIPTION
        Bound to MedProPowerProfileButton. Fast enough to run on the UI thread.
    #>
    [CmdletBinding()]
    param()

    Set-MedProUIState -Enabled $false -Status "Applying the power profile..."

    try {
        Write-MedProLog "Applying the MedPro power profile..."
        $success = Set-MedProPowerProfile

        if ($success) {
            Write-MedProLog "Power profile applied." -Level Success
        } else {
            Write-MedProLog "Power profile applied with warnings - check the lines above." -Level Warning
        }
    } finally {
        Set-MedProUIState -Enabled $true -Status "Ready"
    }
}
#endregion

#region public/Invoke-MedProRemoveAppsButton.ps1
function Invoke-MedProRemoveAppsButton {
    <#
    .SYNOPSIS
        Removes the selected groups of Windows bloatware.

    .DESCRIPTION
        Bound to MedProRemoveAppsButton.

        This is the one destructive operation in the tool. Unlike a tweak, there
        is no OriginalValue to put back - reinstalling a removed Store app means
        going to the Store. The confirmation says that plainly rather than
        implying a symmetry with the Tweaks tab that does not exist.

        The keep-list guard lives in Remove-MedProAppx, so it protects this path
        and any future caller equally.
    #>
    [CmdletBinding()]
    param()

    $selected = Get-MedProSelection -ControlSet $sync.DebloatCheckBoxes

    if ($selected.Count -eq 0) {
        Write-MedProLog "Nothing selected - tick the app groups you want removed." -Level Warning
        return
    }

    $groupNames = @($selected | ForEach-Object { $sync.configs.debloat.groups.$_.content })

    $message  = "Remove these app groups from this machine?`n`n"
    $message += ($groupNames | ForEach-Object { "  - $_" }) -join "`n"
    $message += "`n`nThis cannot be undone from this tool. Reinstalling a removed app means going to the Microsoft Store."

    $answer = [System.Windows.MessageBox]::Show(
        $message, "MedPro Utility",
        [System.Windows.MessageBoxButton]::OKCancel,
        [System.Windows.MessageBoxImage]::Warning)

    if ($answer -ne [System.Windows.MessageBoxResult]::OK) {
        Write-MedProLog "Cancelled - no apps were removed."
        return
    }

    $sync.PendingDebloat = $selected

    Invoke-MedProRunspace -ActivityName "Removing apps" -ScriptBlock {

        $keepList = @($sync.configs.debloat.keepList)
        Write-MedProLog "----- Removing $($sync.PendingDebloat.Count) app groups -----"

        $totalRemoved = 0
        $totalBlocked = 0
        $totalFailed  = 0

        foreach ($name in $sync.PendingDebloat) {
            $group = $sync.configs.debloat.groups.$name
            if ($null -eq $group) {
                Write-MedProLog "'$name' is selected but missing from the config - skipped." -Level Error
                continue
            }

            Write-MedProLog "$($group.content)"
            $result = Remove-MedProAppx -Pattern @($group.packages) -KeepList $keepList

            $totalRemoved += $result.Removed
            $totalBlocked += $result.Blocked
            $totalFailed  += $result.Failed

            if ($result.Removed -eq 0 -and $result.Failed -eq 0) {
                Write-MedProLog "  nothing to remove - none of these are installed."
            }
        }

        Write-MedProLog "----- $totalRemoved packages removed -----" -Level $(if ($totalFailed) { "Warning" } else { "Success" })

        if ($totalBlocked -gt 0) {
            Write-MedProLog "$totalBlocked package(s) were protected by the keep-list and left in place." -Level Warning
        }
        if ($totalFailed -gt 0) {
            Write-MedProLog "$totalFailed removal(s) failed. Some packages are locked by Windows and can only be removed offline." -Level Warning
        }

        Write-MedProLog "Apply the matching policy tweaks on the Tweaks tab so Windows does not reinstall these on the next feature update." -Level Warning
    }
}
#endregion

#region public/Invoke-MedProRenameButton.ps1
function Invoke-MedProRenameButton {
    <#
    .SYNOPSIS
        Renames this machine to the value typed on the Provisioning tab.

    .DESCRIPTION
        Bound to MedProRenameButton. Runs on the UI thread: a rename is a single
        fast call, so pushing it to a runspace would add complexity without
        making the window any more responsive.
    #>
    [CmdletBinding()]
    param()

    $newName = $sync.MedProComputerNameBox.Text

    $result = Rename-MedProComputer -NewName $newName

    if (-not $result.Success) {
        [System.Windows.MessageBox]::Show(
            $result.Message, "MedPro Utility",
            [System.Windows.MessageBoxButton]::OK,
            [System.Windows.MessageBoxImage]::Warning) | Out-Null
        return
    }

    Set-MedProUIState -Enabled $true -Status $result.Message

    if ($result.RebootRequired) {
        $sync.RebootPending = $true
        $sync.MedProCurrentNameLabel.Text = "$env:COMPUTERNAME  ->  $newName after reboot"
    }
}
#endregion

#region public/Invoke-MedProSelectRecommendedAppsButton.ps1
function Invoke-MedProSelectRecommendedAppsButton {
    <#
    .SYNOPSIS
        Ticks the app groups MedPro removes from every workstation.

    .DESCRIPTION
        Bound to MedProSelectRecommendedAppsButton. Ticks every group marked
        "recommended": true and leaves anything marked caution alone - the
        OEM group in particular matches loosely enough that it should be a
        deliberate choice, not part of a one-click default.
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.DebloatCheckBoxes -or $sync.DebloatCheckBoxes.Count -eq 0) { return }

    $count = 0
    foreach ($name in $sync.DebloatCheckBoxes.Keys) {
        $group = $sync.configs.debloat.groups.$name
        $isRecommended = ($group.recommended -eq $true) -and ($group.caution -ne $true)

        $sync.DebloatCheckBoxes[$name].IsChecked = $isRecommended
        if ($isRecommended) { $count++ }
    }

    Write-MedProLog "Selected the $count app groups MedPro removes from a standard workstation."
}
#endregion

#region public/Invoke-MedProSelectRecommendedButton.ps1
function Invoke-MedProSelectRecommendedButton {
    <#
    .SYNOPSIS
        Ticks the tweaks MedPro IT applies to every workstation.

    .DESCRIPTION
        Bound to MedProSelectRecommendedButton. Ticks every tweak whose config
        entry carries "recommended": true, which is how the standard MedPro
        workstation build is expressed.

        Anything marked caution is deliberately left unticked - the recommended
        set is the one a technician can apply without thinking, so it must not
        contain a choice that needs thinking about.
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.TweakCheckBoxes -or $sync.TweakCheckBoxes.Count -eq 0) { return }

    $count = 0
    foreach ($name in $sync.TweakCheckBoxes.Keys) {
        $tweak = $sync.configs.tweaks.$name
        $isRecommended = ($tweak.recommended -eq $true) -and ($tweak.caution -ne $true)

        $sync.TweakCheckBoxes[$name].IsChecked = $isRecommended
        if ($isRecommended) { $count++ }
    }

    Write-MedProLog "Selected the $count recommended tweaks for a standard MedPro workstation."
}
#endregion

#region public/Invoke-MedProSelectStandardAppsButton.ps1
function Invoke-MedProSelectStandardAppsButton {
    <#
    .SYNOPSIS
        Ticks the applications that go on every MedPro workstation.

    .DESCRIPTION
        Bound to MedProSelectStandardAppsButton. Ticks every catalog entry marked
        "standard": true - the MedPro base image software list, as opposed to
        role-specific software a technician adds deliberately.
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.InstallCheckBoxes -or $sync.InstallCheckBoxes.Count -eq 0) { return }

    $count = 0
    foreach ($name in $sync.InstallCheckBoxes.Keys) {
        $isStandard = $sync.configs.applications.$name.standard -eq $true
        $sync.InstallCheckBoxes[$name].IsChecked = $isStandard
        if ($isStandard) { $count++ }
    }

    Write-MedProLog "Selected the $count applications in the MedPro standard build."
}
#endregion

#region public/Invoke-MedProToggleLogButton.ps1
function Invoke-MedProToggleLogButton {
    <#
    .SYNOPSIS
        Opens and closes the full activity log pane.

    .DESCRIPTION
        The log pane is collapsed at startup so that each tab fits the window
        without scrolling; the strip above it still shows the most recent line,
        so nothing is invisible, only compact.

        Set-MedProUIState opens the pane on its own when a task starts, which is
        the case where a technician actually needs the running detail.

    .EXAMPLE
        Invoke-MedProToggleLogButton
    #>
    [CmdletBinding()]
    param()

    if (-not $sync.MedProLogPanel) { return }

    $isOpen = $sync.MedProLogPanel.Visibility -eq [System.Windows.Visibility]::Visible

    $sync.MedProLogPanel.Visibility = if ($isOpen) {
        [System.Windows.Visibility]::Collapsed
    } else {
        [System.Windows.Visibility]::Visible
    }

    if ($sync.MedProToggleLogButton) {
        $sync.MedProToggleLogButton.Content = if ($isOpen) { "Show full log" } else { "Hide full log" }
    }

    # Reopening on a long session should land at the newest line, not wherever
    # the technician left the scroll position before collapsing it.
    if (-not $isOpen -and $sync.MedProLogOutput) { $sync.MedProLogOutput.ScrollToEnd() }
}
#endregion

#region public/Invoke-MedProUndoTweaksButton.ps1
function Invoke-MedProUndoTweaksButton {
    <#
    .SYNOPSIS
        Reverses every ticked tweak, restoring the original values.

    .DESCRIPTION
        Bound to MedProUndoTweaksButton. Each tweak is put back using the
        OriginalValue and OriginalType recorded in the config.

        Undo restores what the config says stock Windows 11 looks like, which is
        not necessarily what this particular machine looked like before the tool
        ran. On a machine carrying pre-existing Group Policy or an OEM
        customization, System Restore is the more faithful way back - so the
        confirmation says so rather than overstating what this button does.
    #>
    [CmdletBinding()]
    param()

    $selected = Get-MedProSelection -ControlSet $sync.TweakCheckBoxes

    if ($selected.Count -eq 0) {
        Write-MedProLog "Nothing selected - tick the tweaks you want to reverse." -Level Warning
        return
    }

    # One-shot actions have no reverse. Saying so up front beats a run that
    # reports "skipped" for half the selection.
    $reversible = @($selected | Where-Object { $sync.configs.tweaks.$_.action -ne $true })
    $oneShot    = $selected.Count - $reversible.Count

    if ($reversible.Count -eq 0) {
        Write-MedProLog "Everything selected is a one-time action - there is nothing to reverse." -Level Warning
        return
    }

    $message = "Reverse $($reversible.Count) tweak$(if ($reversible.Count -ne 1) { 's' })?"
    if ($oneShot -gt 0) {
        $message += "`n`n$oneShot selected item$(if ($oneShot -ne 1) { 's are' } else { ' is' }) a one-time action and will be skipped."
    }
    $message += "`n`nThis restores stock Windows 11 values. If this machine had its own settings before the tool ran, use System Restore instead."

    $answer = [System.Windows.MessageBox]::Show(
        $message, "MedPro Utility",
        [System.Windows.MessageBoxButton]::OKCancel,
        [System.Windows.MessageBoxImage]::Question)

    if ($answer -ne [System.Windows.MessageBoxResult]::OK) {
        Write-MedProLog "Cancelled - nothing was changed."
        return
    }

    $sync.PendingTweaks = $reversible

    Invoke-MedProRunspace -ActivityName "Reversing tweaks" -ScriptBlock {

        Write-MedProLog "----- Reversing $($sync.PendingTweaks.Count) tweaks -----"

        $results = foreach ($name in $sync.PendingTweaks) {
            $tweak = $sync.configs.tweaks.$name
            if ($null -eq $tweak) {
                Write-MedProLog "'$name' is selected but missing from the config - skipped." -Level Error
                continue
            }
            Invoke-MedProTweak -Name $name -Tweak $tweak -Mode Undo
        }

        $results = @($results)
        $failed  = @($results | Where-Object { -not $_.Success })

        Write-MedProLog "----- $($results.Count - $failed.Count) of $($results.Count) reversed cleanly -----" -Level $(if ($failed.Count) { "Warning" } else { "Success" })

        foreach ($failure in $failed) {
            Write-MedProLog "Review: $($failure.Content)" -Level Warning
        }

        if (@($results | Where-Object { $_.RestartExplorer }).Count -gt 0) {
            Restart-MedProExplorer
        }

        if (@($results | Where-Object { $_.RestartRequired }).Count -gt 0) {
            Write-MedProLog "A reboot is required before some of these changes take effect." -Level Warning
        }
    }
}
#endregion
#endregion

#region Startup
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
#endregion

#region Main
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
#endregion
