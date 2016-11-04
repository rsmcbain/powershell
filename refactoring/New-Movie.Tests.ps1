$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "New Movie Basic - Star Wars, 0" {
    BeforeEach {
        $Price  = New-RegularPrice 
        $Movie  = New-Movie -Title "Star Wars" -Price $Price
    }
    It "Title is Star Wars" {
        $Movie.Title | Should Be "Star Wars"
    }
}
Describe "New Movie Invalid PriceCode - Star Wars, RegularPrice" {
    It "Validates Price Code" {
        $Price = $null
       {$Movie  = New-Movie -Title "Star Wars" -Price $Price}  | Should Throw "Cannot validate argument on parameter 'Price'"
    }
}
Describe "New Movie Invalid - null title" {
    It "Validates Missing Title" {
        $Price  = New-RegularPrice 
       {$Movie  = New-Movie -Price $Price -Title $null}  | Should Throw "Cannot bind argument to parameter 'Title' because it is an empty string"
    }
}
Describe "New Movie Defaults PriceCode=0 - Star Wars, null" {
    It "Regular Price charge for 1 day is 2 " {
       $Price  = New-RegularPrice
       $Movie  = New-Movie -Title "Star Wars" -Price $Price
       $Movie.Price.charge(1)  | Should Be 2
    }
    It "Regular Price charge for 3 days is 3 " {
       $Price  = New-RegularPrice
       $Movie  = New-Movie -Title "Star Wars" -Price $Price
       $Movie.Price.charge(1)  | Should Be 2
    }
}
