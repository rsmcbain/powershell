$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "New Movie Basic - Star Wars, 0" {
    BeforeEach {
        $Movie  = New-Movie -Title "Star Wars" -PriceCode 0
    }
    It "Title is Star Wars" {
        $Movie.Title | Should Be "Star Wars"
    }
    It "PriceCode is 0 (Regular)" {
        $Movie.PriceCode | Should Be 0
    }
}
Describe "New Movie Invalid PriceCode - Star Wars, 4" {
    It "Validates Price Code" {
       {$Movie  = New-Movie -Title "Star Wars" -PriceCode 4}  | Should Throw "Cannot validate argument on parameter 'PriceCode'"
    }
}
Describe "New Movie Invalid - null, 0" {
    It "Validates Missing Title" {
       {$Movie  = New-Movie -PriceCode 4}  | Should Throw "Cannot validate argument on parameter 'PriceCode'"
    }
}
Describe "New Movie Defaults PriceCode=0 - Star Wars, null" {
    It "Missing Price Code defaults to 0" {
       $Movie  = New-Movie -Title "Star Wars"
       $Movie.PriceCode  | Should Be 0
    }
}
