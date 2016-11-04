function New-NewReleasePrice {
    $p = New-Object psobject -property @{
        PriceType = 0
    }
    $p.PSObject.TypeNames.Insert(0,'Price')
    $p.PSObject.TypeNames.Insert(0,'NewReleasePrice')
    $p | Add-Member -MemberType ScriptMethod -Name charge -Value {
        param(
            [Parameter(Mandatory=$true)]
            [int] $daysRented
        )
        3
    }
    $p | Add-Member -MemberType ScriptMethod -Name renterPoints -Value {
        param(
            [Parameter(Mandatory=$true)]
            [int] $daysRented
        )
        $result = if ($daysRented -gt 1) {2} else {1}
    }
    $p
}
