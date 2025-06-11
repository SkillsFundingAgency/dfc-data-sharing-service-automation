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

  @customers @get
  Scenario: GET multiple (invalid; no API key)
    When User sends GET customers request with customerid and without api key
    Then User verifies the status code is "401"
  
  @customers @get
  Scenario: GET multiple (invalid; no touchpoint id)
    When User sends GET customers request with customerid and without touchpoint id
    Then User verifies the status code is "400"

  @customers @get
  Scenario: GET multiple (invalid; no api version)
    When User sends GET customers request with customerid and without api version
    Then User verifies the status code is "404"