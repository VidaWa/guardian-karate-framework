@Smoke
Feature: Token Verify Feature

	Background: Setup Test
		Given url "https://tek-insurance-api.azurewebsites.net"

 	#4
 	Scenario: Verify a valid token
 		And path "/api/token"
 		And request {"username": "supervisor","password": "tek_supervisor"} 
	  When method post
	  Then status 200
	  And print response
	  Then path "/api/token/verify"
 		And param username =  "supervisor"
 		And param password = "tek_supervisor" 
 		And param token = response.token
	  When method get
	  Then status 200
# Everytime you send a request the response will be overwrite with the new response
	  And print response
	  And assert response == "true"
	  
	 #5 
	 Scenario: Verify token with invalid username
	  And path "/api/token"
 		And request {"username": "supervisor","password": "tek_supervisor"} 
	  When method post
	  Then status 200
	  And print response
	  Then path "/api/token/verify"
 		And param username =  "WrongUsername"
 		And param token = response.token
	  When method get
	  Then status 400
	  And print response
	  And assert response.errorMessage == "Wrong Username send along with Token"
	  
	 #6 
	 Scenario: Verify invalid token with valid username
	  And path "/api/token/verify"
 		And param username =  "supervisor"
 		And param token = "WrongToken"
	  When method get
	  Then status 400
	  And print response
	  And assert response.errorMessage == "Token Expired or Invalid Token"
	   	