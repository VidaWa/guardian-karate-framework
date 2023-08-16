@Regression
Feature: Create Account Feature

	Background: Setup Test and Generate
		# callonce read is used to call another feature file
		* def result = callonce read('GenerateToken.feature')
		* def validToken = result.response.token
		Given url "https://tek-insurance-api.azurewebsites.net"
		
	#10
	Scenario: Create valid account 
	Given path "/api/accounts/add-primary-account"
	And header Authorization = "Bearer " + validToken
	# calling java class in feature file. This utility will create object from the java class
	* def generateDataObject = Java.type('api.utility.GenerateData')
	* def autoEmail = generateDataObject.getEmail()
	And request
	"""
	{
	 #"email": "guard97@tekschool.com",
	 	"email": "#(autoEmail)",
  	"firstName": "Shafiqa",
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
 #And assert response.email == "guard97@tekschool.com"
	And assert response.email == autoEmail
	# If we want to run this code again it will give error as an account already created with that specific email,
	# so we have to change/edit the code (new email) everytime we want to execute the code and this is not good
	# as 
	# There are two ways to make our code reusable and dynamic
	# 1) Using API calls - Another call to the API to delete the generated account by delete endpoint
	# for continues execution, this is called a test cleanup - continues integration continues delivery
	# 2) Generate data dynamically - new email will be generated each time - it is not coming from karate or a feature
	# of karate but it has the ability to call java methods
	
#	Given path "/api/accounts/delete-account"
#	And param primaryPersonId = response.id
#	And header Authorization = "Bearer " + validToken
#	When method delete
#	Then status 200
#	And print response
#	And assert response == "Account Successfully deleted"
	