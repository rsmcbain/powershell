$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here${directorySeparatorChar}$sut"

Describe "New-Customer" {
    beforeEach {
      $Customer = New-Customer -Name Jake
    }
    It "Simple creation Name=Jake" {
        $Customer.Name | Should Be "Jake"
    }
    It "Simple Creation - Empty Rentals" {
        $Customer.Rentals.Count | Should Be 0
    }
    It "Customer Statement has no rentals" {
        $calc = $Customer.calcStatement()
        $calc | Should Match 'Amount owed is 0'
    }
    It "Customer HtmlStatement has no rentals" {
        $calc = $Customer.calcHtmlStatement()
        $calc | Should Match 'Amount owed is <em>0</em>'
    }
}
Describe "New-Customer Changes" {
    beforeEach { 
      $Price = New-RegularPrice
      $Movie = New-Movie -Title "Vertigo -Price $Price"
      $Rental = New-Rental -Movie $Movie -DaysRented 3
    }
    It "Customer with no rentals and adds 1 yields Rentals length 1" {
        $Cust = New-Customer -Name Bud
        $Cust.Rentals.Add($Rental)
        $Cust.Rentals.Count | Should Be 1
    }
    It "Customer rental added to list" {
        $Cust = New-Customer -Name Bud
        $Cust.Rentals.Add($Rental)
        $Cust.Rentals[0] | Should Be $Rental
    }
    It "Customer Statement has no rentals" {
        $Cust = New-Customer -Name Bud
        $Cust.Rentals.Add($Rental)
        $calc = $Cust.calcStatement()
        $calc | Should Match 'Amount owed is 3.5'
    }
    It "Customer HtmlStatement has no rentals" {
        $Cust = New-Customer -Name Bud
        $Cust.Rentals.Add($Rental)
        $calc = $Cust.calcHtmlStatement()
        $calc | Should Match 'Amount owed is <em>3.5</em>'
    }
    It "Customer with no rentals and adds 2 yields Rentals length 2" {
        $Cust = New-Customer -Name Bud
        $Cust.Rentals.Add($Rental)
        $Cust.Rentals.Add($Rental)
        $Cust.Rentals.Count | Should Be 2
    }
}
