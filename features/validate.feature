Feature: validate luhn check digit

  In order to verify IMEI numbers
  As a user
  I want to verify the luhn check digit

  Scenario: validate check digit for one number
    When I run `ruby_luhn validate 354316045596428`
    Then the output should contain "> 354316045596428  correct"
    
   Scenario: reject invalid input
    When I run `ruby_luhn validate 354316035596428`
    Then the output should contain "> 354316035596428  incorrect"


  Scenario: reject invalid input
    When I run `ruby_luhn validate 3543160d559642`
    Then the output should contain "> 3543160d559642  invalid number"

  Scenario: validate check digit for multiple numbers
    When I run `ruby_luhn validate` interactively
    And I type "354316045596428"
    And I type "354316045596393"
    And I type "354316045596203"
    And I type "exit"
    Then the output should contain "> 354316045596428  correct"
    Then the output should contain "> 354316045596393  incorrect"
    Then the output should contain "> 354316045596203  incorrect"

