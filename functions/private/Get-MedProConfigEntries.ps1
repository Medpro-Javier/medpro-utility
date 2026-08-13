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
