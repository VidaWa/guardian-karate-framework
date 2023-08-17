@EndtoEnd
Feature: End to End Test for Account Creation

	Background: Setup Test and Generate
			Given url "https://tek-insurance-api.azurewebsites.net"
			* def result = callonce read('GenerateToken.feature')
			* def validToken = result.response.token
			* def dataGenerator = Java.type('api.utility.GenerateData')
			
			
	Scenario: End to End Test for Account Creation
			# Adding Account
			Given path "/api/accounts/add-primary-account"
			And header Authorization = "Bearer " + validToken
			* def autoEmail = dataGenerator.getEmail()
			And request
			"""
			{
			 	"email": "#(autoEmail)",
		  	"firstName": "Karima",
		  	"lastName": "Ajmal",
		  	"title": "Mrs. ",
		  	"gender": "FEMALE",
		  	"maritalStatus": "MARRIED",
		  	"employmentStatus": "Tester",
		  	"dateOfBirth": "2023-08-02"
			}
			
			"""
			When method post
			Then status 201
			And print response
			And assert response.email == autoEmail
			* def createdAccountId = response.id
			
			# Adding Phone Number
			Given path "/api/accounts/add-account-phone"
			And param primaryPersonId = createdAccountId
			And header Authorization = "Bearer " + validToken
			* def phoneNumber = dataGenerator.getPhoneNumber()
			And request
			"""
			{
				"phoneNumber": "#(phoneNumber)",
				"phoneExtension": "",
				"phoneTime": "Evening",
				"phoneType": "Mobile"
			}
			
			"""
			When method post
			Then status 201
			And assert response.phoneNumber == phoneNumber
			
			# Adding Address
			Given path "/api/accounts/add-account-address"
			And param primaryPersonId = createdAccountId
			And header Authorization = "Bearer " + validToken
			And request
			"""
			{
			  "addressType": "Home",
			  "addressLine1": "1122 King Rd",
			  "city": "HayMarket",
			  "state": "VA",
			  "postalCode": "22243",
			  "countryCode": "001",
			  "current": true
			}
			
			"""
			When method post
			Then status 201
			
			# Adding Car
			Given path "/api/accounts/add-account-car"
			And param primaryPersonId = createdAccountId
			And header Authorization = "Bearer " + validToken
			* def dataGenerator = Java.type('api.utility.GenerateData')
			* def licensePlateNum = dataGenerator.getLicensePlateNumber()
			And request
			"""
			{
			 "make": "Toyota",
  		 "model": "Camry",
  		 "year": "2020",
  		 "licensePlate": "#(licensePlateNum)"
			}
			
			"""
			When method post
			Then status 201
			And assert response.licensePlate == licensePlateNum
			
			# Deleting Account
			Given path "/api/accounts/delete-account"
			And header Authorization = "Bearer " + validToken
			And param primaryPersonId = createdAccountId
			When method delete
			Then status 200
			And print response
			And assert response == "Account Successfully deleted"
			
		
		
		