@Regression
Feature: Verify Account

  Background: setup test
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def result = callonce read('GenerateToken.feature')
    And print result
    # every dot reperesent an object
    * def validToken = result.response.token
  #7
  Scenario: Verify and account that is exist    
        Given path "/api/accounts/get-account"
        #with def step create variable and assign value for reusability
        * def existingId = 18
        And param primaryPersonId = existingId
        #Header have to add to request. 
        And header Authorization = "Bearer " + validToken
        When method get
        Then status 200
        And print response
        And assert response.primaryPerson.id == existingId
  #8
  Scenario: Verify get-account with id not exist
        Given path "/api/accounts/get-account"
        And header Authorization = "Bearer " + validToken
        And param primaryPersonId = 10
        When method get
        Then status 404
        And print response
        And assert response.errorMessage == "Account with id 10 not found"