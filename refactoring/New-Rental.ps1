function New-Rental {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateScript({$_.PSObject.TypeNames[0] -eq 'Movie' })]
        $Movie,
        [Parameter(Mandatory=$true)]
        [int] $DaysRented
    )
    $r = New-Object psobject -property @{
        Movie = $Movie
        DaysRented = $DaysRented
    }
    $r.PSObject.TypeNames.Insert(0,'Rental')
    $r | Add-Member -MemberType ScriptMethod -Name charge -Value {
        $this_amount = 0
        # calc amounts for each line
        switch ($this.Movie.PriceCode) {
            0 {
                $this_amount += 2
                if ($this.DaysRented > 2) {
                    $this_amount += ($this.DaysRented -2 ) *1.5
                }
            }
            1 {
                $this_amount += $this.DaysRented * 3
            }
            2 {
                $this_amount += 1.5
                if ($this.DaysRented > 3) {
                    $this_amount += ($this.DaysRented -3 ) *1.5
                }
            }
            default { 0 }
        }
        $this_amount
    }
    $r | Add-Member -MemberType ScriptMethod -Name frequentRenterPoints -Value {
      $result = if (($this.Movie.PriceCode = 1) -and ($this.days_rented > 1)) {2} else {1}
      $result
    }
    $r
}

