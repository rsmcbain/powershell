function New-Movie {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Title,
        [Parameter(Mandatory=$false)]
        [ValidateScript({$_.PSObject.TypeNames[0] -eq 'Price' })]
        $Price
    )
    $m = New-Object psobject -property @{
        Title = $Title
        Price = $Price
    }
    $m.PSObject.TypeNames.Insert(0,'Movie')
    $m | Add-Member -MemberType ScriptMethod -Name charge -Value {
        param (
            [Parameter(Mandatory=$true)]
            [int]$daysRented
        )
        $Price.charge($daysRented)
    }
    $m | Add-Member -MemberType ScriptMethod -Name frequentRenterPoints -Value {
        param (
            [Parameter(Mandatory=$true)]
            [int]$daysRented
        )
      $Price.renterPoints($daysRented)
    }
    $m
}
