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
