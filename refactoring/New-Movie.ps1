function New-Movie {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Title,
        [Parameter(Mandatory=$false)]
        [ValidateSet(0,1,2)]
        [int]$PriceCode = 0
    )
    $m = New-Object psobject -property @{
        Title = $Title
        PriceCode = $PriceCode
    }
    $m.PSObject.TypeNames.Insert(0,'Movie')
    $m
}
