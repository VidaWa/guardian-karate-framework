@Regression
Feature: Verify Account 

	Background: Setup Test
		Given url "https://tek-insurance-api.azurewebsites.net"
	#7
	Scenario: Verify an account that exists
		And path "/api/token"
 		And request {"username": "supervisor","password": "tek_supervisor"} 
	  When method post
	  Then status 200
	  And print response
	  Then path "/api/accounts/get-account"
	  # With def (define) step (using wild card) we can create variables and assign values for reusability
	  * def existingId = 18
 		And param primaryPersonId =  existingId
 		# Headrer has to be added to the request.
 		And header Authorization = "Bearer " + response.token
	  When method get
	  Then status 200
	  And print response
	  And assert response.primaryPerson.id == existingId
		
	#8
	Scenario: Verify an account that doesnt exist
		And path "/api/token"
 		And request {"username": "supervisor","password": "tek_supervisor"} 
	  When method post
	  Then status 200
	  And print response
	  Then path "/api/accounts/get-account"
 		And param primaryPersonId =  "10"
 		And header Authorization = "Bearer " + response.token
	  When method get
	  Then status 404
	  And print response
	  And assert response.errorMessage == "Account with id 10 not found" 
