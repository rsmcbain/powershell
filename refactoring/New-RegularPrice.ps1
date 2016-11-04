function New-RegularPrice {
    $p = New-Object psobject -property @{
        PriceType = 0
    }
    $p.PSObject.TypeNames.Insert(0,'Price')
    $p.PSObject.TypeNames.Insert(1,'RegularPrice')
    $p | Add-Member -MemberType ScriptMethod -Name charge -Value {
        param(
            [Parameter(Mandatory=$true)]
            [int] $daysRented
        )
        $result = 2
        if ($daysRented -gt 2) {
            $result += ($daysRented -2) * 1.5 
        }
        $result
    }
    $p | Add-Member -MemberType ScriptMethod -Name renterPoints -Value {
        param(
            [Parameter(Mandatory=$true)]
            [int] $daysRented
        )
        1
    }
    $p
}
