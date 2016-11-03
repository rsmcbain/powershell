function New-Customer {
    param(
        [Parameter(Mandatory=$true)]
        [String] $Name
    )
    $c = New-Object psobject -property @{
        Name = $Name
        Rentals = New-Object System.Collections.ArrayList
    }
    $c.PSObject.TypeNames.Insert(0,'Customer')
    $c | Add-Member -MemberType ScriptMethod -Name calcStatement -Value {
        $result = $null
        $total_amount, $frequent_renter_points = 0, 0
        $result = "Rental record for {0}`r`n" -f $this.Name
        foreach ($rental in $this.Rentals) {
            # calc frequent renter points
            $frequent_renter_points += 1
            if ($rental.Movie.PriceCode = 1) {
                $frequent_renter_points += 1
            }
            $total_amount += $rental.charge
            $result += "`t{0}`t{1}`r`n" -f $rental.Movie.Title, $rental.charge
        }
    $result += "Amount owed is {0}`n`r" -f $total_amount
    $result += "You have earned {0} frequent renter points`n`r" -f $frequent_renter_points
    "$result"
    }
    $c
}
