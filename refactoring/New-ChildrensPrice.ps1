function New-ChildrensPrice {
    $p = New-Object psobject -property @{
        PriceType = 0
    }
    $p.PSObject.TypeNames.Insert(0,'Price')
    $p.PSObject.TypeNames.Insert(0,'ChildrensPrice')
    $p | Add-Member -MemberType ScriptMethod -Name charge -Value {
        param(
            [Parameter(Mandatory=$true)]
            [int] $daysRented
        )
        $result = 1.5
        if ($daysRented -gt 3) {
            $result += ($daysRented -3) * 1.5
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
