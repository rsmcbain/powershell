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
        $result = "Rental record for {0}`r`n" -f $this.Name
        foreach ($rental in $this.Rentals) {
            $result += "`t{0}`t{1}`r`n" -f $rental.Movie.Title, $rental.charge()
        }
    $result += "Amount owed is {0}`n`r" -f $this.totalCharge()
    $result += "You have earned {0} frequent renter points`n`r" -f $this.frequentRenterPoints()
    "$result"
    }
    $c | Add-Member -MemberType ScriptMethod -Name calcHtmlStatement -Value {
        $result = $null
        $result = "<h1>Rental record for <em>{0}</em></h1>`r`n" -f $this.Name
        foreach ($rental in $this.Rentals) {
            $result += "<p>`t{0}`t{1}</p>`r`n" -f $rental.Movie.Title, $rental.charge()
        }
    $result += "Amount owed is <em>{0}</em>`n`r" -f $this.totalCharge()
    $result += "You have earned <em>{0}</em> frequent renter points`n`r" -f $this.frequentRenterPoints()
    "$result"
    }
    $c | Add-Member -MemberType ScriptMethod -Name totalCharge -Value {
        $total = 0
        foreach ($rental in $this.Rentals) { $total += $rental.charge() }
        $total
    }
    $c | Add-Member -MemberType ScriptMethod -Name frequentRenterPoints -Value {
        $total = 0
        foreach ($rental in $this.Rentals) { $total += $rental.frequentRenterPoints() }
        $total
    }
    $c
}
