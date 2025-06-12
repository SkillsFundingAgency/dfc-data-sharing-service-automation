Feature: DSS Customers
	
	Background: Post Customer
		When User sends POST customers request with no ids and the following details
		| Field                      | Value                |
		| DateOfRegistration         | 2018-07-27T16:11:00Z |
		| Title                      | 1                    |
		| GivenName                  | Bob                  |
		| FamilyName                 | Customer             |
		| DateofBirth                | 2005-07-26T13:45:00Z |
		| Gender                     | 1                    |
		| UniqueLearnerNumber        | 9876543210           |
		| OptInUserResearch          | true                 |
		| OptInMarketResearch        | false                |
		| IntroducedBy               | 1                    |
		| IntroducedByAdditionalInfo | additional info      |
		| LastModifiedDate           | 2018-06-21T14:45:00Z |
		| PriorityGroups             | [1, 3]               |
	Then User verifies the status code is "201"
	And Response should contain
		| Field                      | Value                |
		| DateOfRegistration         | 2018-07-27T16:11:00Z |
		| Title                      | 1                    |
		| GivenName                  | Bob                  |
		| FamilyName                 | Customer             |
		| DateofBirth                | 2005-07-26T13:45:00Z |
		| Gender                     | 1                    |
		| UniqueLearnerNumber        | 9876543210           |
		| OptInUserResearch          | true                 |
		| OptInMarketResearch        | false                |
		| IntroducedBy               | 1                    |
		| IntroducedByAdditionalInfo | additional info      |
		| LastModifiedDate           | 2018-06-21T14:45:00Z |
		| PriorityGroups             | [1, 3]               |	

	@customers @patch
    Scenario: PATCH customer (invalid; no API key)
		When User sends PATCH customers request with customerid and the following details without api key
			| Field          | Value    |
			| GivenName      | Bob      |
			| FamilyName     | Customer |
			| IntroducedBy   | 99       |
			| PriorityGroups | [1, 3]   |
		Then User verifies the status code is "401"
  
    @customers @patch
    Scenario: PATCH customer (invalid; no touchpoint id)
		When User sends PATCH customers request with customerid and the following details without touchpoint id
		| Field          | Value    |
		| GivenName      | Bob      |
		| FamilyName     | Customer |
		| IntroducedBy   | 99       |
		| PriorityGroups | [1, 3]   |
		Then User verifies the status code is "400"

    @customers @patch
    Scenario: PATCH customer (invalid; no api version)
		When User sends PATCH customers request with customerid and the following details without api version
		| Field          | Value    |
		| GivenName      | Bob      |
		| FamilyName     | Customer |
		| IntroducedBy   | 99       |
		| PriorityGroups | [1, 3]   |
		Then User verifies the status code is "404"

	@customers @validation @patch
	Scenario: Patch Customer with invalid values to validate ErrorMessage returned
    When User sends PATCH customers request with customerid and the following details
		| Field                      | Value                |
		| DateOfRegistration		 | 2048-07-27T16:11:00Z |
		| Title						 | 0                    |
		| GivenName					 | Bob                  |
		| FamilyName				 | Customer             |
		| DateofBirth				 | 2018-07-26T13:45:00Z |
		| Gender					 | 0                    |
		| UniqueLearnerNumber	 	 | 987654321            |
		| IntroducedBy				 | 0                    |
		| LastModifiedDate			 | 2048-06-21T14:45:00Z |
		| PriorityGroups			 | [1,6]                  |
	Then User verifies the status code is "422"
	And Response should contain error
		| ErrorMessage                                                                   |
		| Can not be 18 to 24 and over 50 at the same time                               |
		| Please supply a valid Introduced By value                                      |
		| Please supply a valid Gender                                                   |
		| Please supply a valid Title                                                    |
		| Unique Learner Number must be greater than 1000000000 and less than 9999999999 |
		| Customer must be at least 13 years old to use this service.                    |
		| Last Modified Date must be less the current date/time                          |
		| Date of Registration must be less the current date/time                        |


	@customers @patch
	Scenario: Patch DateOfTermination and ReasonForTermination
    When User sends PATCH customers request with customerid and the following details
		| Field                      | Value                |
		| DateOfTermination			 | 2018-07-29T16:11:00Z |
		| ReasonForTermination		 | 2					|
	Then User verifies the status code is "200"
	And Response should contain
		| Field                      | Value                |
		| DateOfTermination          | 2018-07-29T16:11:00Z |
		| ReasonForTermination		 | 2					|