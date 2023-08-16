@Smoke
Feature: Security Token Tests

Background: Setaup Test
		Given url "https://tek-insurance-api.azurewebsites.net"
	  And path "/api/token"
	  
  #1
  Scenario: Generate valid token with valid username and password
	  And request {"username": "supervisor","password": "tek_supervisor"} 
	  When method post
	  Then status 200
	  And print response
  
#  Scenario: Validate token with invalid username
#	  And request {"username": "wrongUsername","password": "tek_supervisor"}
#	  When method post
#	  Then status 400 
#	  And print response
#	  And assert response.errorMessage == "User not found"
	  
#	 Scenario: Validate token with invalid password
#	  And request {"username": "supervisor","password": "wrongpassword"}
#	  When method post
#	  Then status 400 
#	  And print response
#	  And assert response.errorMessage == "Password Not Matched"

# Instead of the above two scnarios we can use one scenario which is actually 
# Scenario Outline with the different values

# Both single quotes and double quotes work the same for the values

	#2 & 3
	Scenario Outline: Validate token with valid and invalid credentials
	  And request {"username": "<userName>","password": "<password>"}
	  When method post
	  Then status 400 
	  And print response
	  And assert response.errorMessage == "<errorMessage>"
	  
	  Examples: 
		  |userName|password|errorMessage|
		  |wrong|tek_supervisor|User not found|
		  |supervisor|wrong|Password Not Matched|
	  
	  