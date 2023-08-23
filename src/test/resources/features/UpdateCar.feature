Feature: Update an account car

	Background: 
			Given url "https://tek-insurance-api.azurewebsites.net"
			* def result = callonce read('GenerateToken.feature')
			* def validToken = result.response.token
		#	* def dataGenerator = Java.type('api.utility.GenerateData')
	Scenario: Update an account car
			Given path "/api/accounts/update-account-car"
			And param primaryPersonId = "11529"
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
			When method put
			Then status 202
			And assert response.licensePlate == licensePlateNum