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
      $Movie.charge($this.DaysRented)
    }
    $r | Add-Member -MemberType ScriptMethod -Name frequentRenterPoints -Value {
      $Movie.frequentRenterPoints()
    }
    $r
}

