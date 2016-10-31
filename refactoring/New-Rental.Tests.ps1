$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here${directorySeparatorChar}$sut"

Describe "New-Rental Basic creation" {
    beforeEach {
      $Movie = New-Movie -Title "Being There" -PriceCode 0
      $Rental = New-Rental -Movie $Movie -DaysRented 3
    }
    It "Rental Movie matches Supplied Movie" {
        $Rental.Movie | Should Match $Movie
    }
    It "Rental DaysRented equals set value (3)" {
        $Rental.DaysRented | Should Be 3
    }
}
