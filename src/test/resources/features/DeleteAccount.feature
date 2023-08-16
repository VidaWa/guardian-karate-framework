@Regression
Feature: Delete Account Feature

	
	Background: Setup Test and Generate
		* def createAccount = callonce read('CreateAccount.feature')
		* def validToken = createAccount.validToken
		* def createdAccountId = createAccount.response.id
		And print createAccount
		Given url "https://tek-insurance-api.azurewebsites.net"
		
	
	#11 & 13
	Scenario: Delete valid and invalid account
	# Account should be existed to be deleted - 200
	# Account should not be existed - 404
		# valid account
		Given path "/api/accounts/delete-account"
		And header Authorization = "Bearer " + validToken
		And param primaryPersonId = createdAccountId
		When method delete
		Then status 200
		And print response
		And assert response == "Account Successfully deleted"
		# invalid account
		Given path "/api/accounts/delete-account"
		And header Authorization = "Bearer " + validToken
		And param primaryPersonId = createdAccountId
		When method delete
		Then status 404
		And print response
		And assert response.errorMessage == "Account with id " +  createdAccountId + " not exist"
	
