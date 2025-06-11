Feature: DSS Customers


    @customers
    Scenario: Post customer (invalid; no API key)
		When User sends POST customers request with no ids and the following details without api key
		| Field          | Value    |
		| GivenName      | Bob      |
		| FamilyName     | Customer |
		| IntroducedBy   | 99       |
		| PriorityGroups | [1, 3]   |
		Then User verifies the status code is "401"
  
    @customers
    Scenario: Post customer (invalid; no touchpoint id)
		When User sends POST customers request with no ids and the following details without touchpoint id
		| Field          | Value    |
		| GivenName      | Bob      |
		| FamilyName     | Customer |
		| IntroducedBy   | 99       |
		| PriorityGroups | [1, 3]   |
		Then User verifies the status code is "400"

    @customers
    Scenario: Post customer (invalid; no api version)
		When User sends POST customers request with no ids and the following details without api version
		| Field          | Value    |
		| GivenName      | Bob      |
		| FamilyName     | Customer |
		| IntroducedBy   | 99       |
		| PriorityGroups | [1, 3]   |
		Then User verifies the status code is "404"

  	@customers
	Scenario: POST customer with subcontractorid (valid request)
		When User sends POST customers request with no ids and the following details - with subcontractorid
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
			| SubcontractorId            | 99999999             |
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

	@customers
	Scenario: POST customer with maximum field lengths (valid request)
		When User sends POST customers request with no ids and the following details
			| Field                      | Value																						        |
			| DateOfRegistration         | 2018-07-27T16:11:00Z                                                                                 |
			| Title                      | 1                                                                                                    |
			| GivenName                  | AbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghij |
			| FamilyName                 | AbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghij |
			| DateofBirth                | 2005-07-26T13:45:00Z                                                                                 |
			| Gender                     | 1                                                                                                    |
			| UniqueLearnerNumber        | 9876543210                                                                                           |
			| OptInUserResearch          | true                                                                                                 |
			| OptInMarketResearch        | false                                                                                                |
			| IntroducedBy               | 1                                                                                                    |
			| IntroducedByAdditionalInfo | AbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghij |
			| LastModifiedDate           | 2018-06-21T14:45:00Z                                                                                 |
			| PriorityGroups             | [1, 3]                                                                                               |
		Then User verifies the status code is "201"
		And Response should contain
			| Field                      | Value																							    |
			| DateOfRegistration         | 2018-07-27T16:11:00Z                                                                                 |
			| Title                      | 1                                                                                                    |
			| GivenName                  | AbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghij |
			| FamilyName                 | AbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghij |
			| DateofBirth                | 2005-07-26T13:45:00Z                                                                                 |
			| Gender                     | 1                                                                                                    |
			| UniqueLearnerNumber        | 9876543210                                                                                           |
			| OptInUserResearch          | true                                                                                                 |
			| OptInMarketResearch        | false                                                                                                |
			| IntroducedBy               | 1                                                                                                    |
			| IntroducedByAdditionalInfo | AbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghijAbcdefghij |
			| LastModifiedDate           | 2018-06-21T14:45:00Z                                                                                 |
			| PriorityGroups             | [1, 3]                                                                                               |

	@customers
	Scenario: Post Customer with only Mandatory fields
		When User sends POST customers request with no ids and the following details
			| Field          | Value    |
			| GivenName      | Bob      |
			| FamilyName     | Customer |
			| IntroducedBy   | 99       |
			| PriorityGroups | [1, 3]   |
		Then User verifies the status code is "201"
		And Response should contain
			| Field                      | Value    |
			| Title                      | 99       |
			| GivenName                  | Bob      |
			| FamilyName                 | Customer |
			| DateofBirth                | none     |
			| Gender                     | 99       |
			| UniqueLearnerNumber        | none     |
			| OptInUserResearch          | false    |
			| OptInMarketResearch        | false    |
			| IntroducedBy               | 99       |
			| IntroducedByAdditionalInfo | none     |
			| PriorityGroups             | [1, 3]   |

	@customers
	Scenario Outline: Names with spaces
		When User sends POST customers request with no ids and the <field> with value <name>
			| Field          | Value    |
			| GivenName      | Bob      |
			| FamilyName     | Customer |
			| IntroducedBy   | 99       |
			| PriorityGroups | [1, 3]   |
		Then User verifies the status code is "201"
		And Response should contain <field> with value <name>
	Examples:
		| field      | name          |
		| GivenName  | Sammy Jo      |
		| GivenName  | Sara-Jane     |
		| GivenName  | Sarah - Jane  |
		| FamilyName | Da Silva      |
		| FamilyName | De La Cruz    |
		| FamilyName | Cohen Il      |
		| FamilyName | Smith-Jones   |
		| FamilyName | Smith - Jones |
	
	@customers @validation
	Scenario: Post Customer with missing mandatory values
		When User sends POST customers request with no ids and the following details
			| Field                      | Value                |
			| Title                      | 13                   |
			| GivenName                  |                      |
			| FamilyName                 |                      |
			| DateofBirth                | 2005-07-26T13:45:00Z |
			| Gender                     | 1                    |
			| DateOfRegistration         | 2018-07-27T16:11:00Z |
			| UniqueLearnerNumber        | 9876543210           |
			| OptInUserResearch          | true                 |
			| OptInMarketResearch        | false                |
			| DateOfTermination          | 2018-07-27T14:45:00Z |
			| ReasonForTermination       | 1                    |
			| IntroducedBy               |                      |
			| IntroducedByAdditionalInfo | additional info      |
			| PriorityGroups             | []                   |
		Then User verifies the status code is "422"
		And Response should contain error
			| ErrorMessage                         |
			| The GivenName field is required.     |
			| The FamilyName field is required.    |
			| The IntroducedBy field is required.  |
			| Please supply a valid Priority Group |

	@customers @validation
	Scenario: Post Customer with Age less than 13 years
		When User sends POST customers request with no ids and the following details
			| Field          | Value                |
			| GivenName      | Bob                  |
			| FamilyName     | Customer             |
			| IntroducedBy   | 99                   |
			| PriorityGroups | [1,3]                |
			| DateofBirth    | 2018-06-21T14:45:00Z |
		Then User verifies the status code is "422"
		And Response should contain error
			| ErrorMessage                         |
			| Customer must be at least 13 years old to use this service     |

	@customers @validation
	Scenario: Post Customer when UniqueLearnerNumber is less than 1000000000
		When User sends POST customers request with no ids and the following details
			| Field               | Value     |
			| GivenName           | Bob       |
			| FamilyName          | Customer  |
			| IntroducedBy        | 99        |
			| PriorityGroups      | [1,3]     |
			| UniqueLearnerNumber | 100000000 |
		Then User verifies the status code is "422"
		And Response should contain error
			| ErrorMessage                                                                   |
			| Unique Learner Number must be greater than 1000000000 and less than 9999999999 |

	@customers @validation
	Scenario: Post Customer when UniqueLearnerNumber is greater than 9999999999
		When User sends POST customers request with no ids and the following details
			| Field               | Value       |
			| GivenName           | Bob         |
			| FamilyName          | Customer    |
			| IntroducedBy        | 99          |
			| PriorityGroups      | [1,3]       |
			| UniqueLearnerNumber | 99999999999 |
		Then User verifies the status code is "422"
		And Response should contain error
			| ErrorMessage                                                                   |
			| Unique Learner Number must be greater than 1000000000 and less than 9999999999 |

    @customers @validation
	Scenario: Post Customer when DateOfRegistration is higher than Current date/time
		When User sends POST customers request with no ids and the following details
			| Field              | Value                |
			| GivenName          | Bob                  |
			| FamilyName         | Customer             |
			| IntroducedBy       | 99                   |
			| PriorityGroups     | [1,3]                |
			| DateOfRegistration | 2048-07-27T16:11:00Z |
		Then User verifies the status code is "422"
		And Response should contain error
			| ErrorMessage                                            |
			| Date of Registration must be less the current date/time |

	@customers @validation
	Scenario:  Post Customer with invalid Title
		When User sends POST customers request with no ids and the following details
			| Field          | Value    |
			| GivenName      | Bob      |
			| FamilyName     | Customer |
			| IntroducedBy   | 99       |
			| PriorityGroups | [1,3]    |
			| Title          | 13       |
		Then User verifies the status code is "422"
		And Response should contain error
			| ErrorMessage                |
			| Please supply a valid Title |

	@customers @validation
	Scenario: Post Customer with invalid Gender input
		When User sends POST customers request with no ids and the following details
			| Field          | Value    |
			| GivenName      | Bob      |
			| FamilyName     | Customer |
			| IntroducedBy   | 99       |
			| PriorityGroups | [1,3]    |
			| Gender         | 10       |
		Then User verifies the status code is "422"
		And Response should contain error
			| ErrorMessage                 |
			| Please supply a valid Gender |

	@customers @validation
	Scenario: Post Customer when DateOfTermination is higher than Current date/time
		When User sends POST customers request with no ids and the following details
			| Field             | Value                |
			| GivenName         | Bob                  |
			| FamilyName        | Customer             |
			| IntroducedBy      | 99                   |
			| PriorityGroups    | [1,3]                |
			| DateOfTermination | 2048-07-27T16:11:00Z |
		Then User verifies the status code is "422"
		And Response should contain error
			| ErrorMessage                                           |
			| Date Of Termination must be less the current date/time |

	@customers @validation
	Scenario: Post Customer when LastModifiedDate is higher than Current date/time
		When User sends POST customers request with no ids and the following details
			| Field            | Value                |
			| GivenName        | Bob                  |
			| FamilyName       | Customer             |
			| IntroducedBy     | 99                   |
			| PriorityGroups   | [1,3]                |
			| LastModifiedDate | 2048-07-27T16:11:00Z |
		Then User verifies the status code is "422"
		And Response should contain error
			| ErrorMessage                                          |
			| Last Modified Date must be less the current date/time |

	@customers @validation
	Scenario: Post Customer with an invalid IntroducedBy value
		When User sends POST customers request with no ids and the following details
			| Field          | Value    |
			| GivenName      | Bob      |
			| FamilyName     | Customer |
			| IntroducedBy   | 0        |
			| PriorityGroups | [1,3]    |
		Then User verifies the status code is "422"
		And Response should contain error
			| ErrorMessage                              |
			| Please supply a valid Introduced By value |

	@customers @validation
	Scenario: Post Customer with an invalid ReasonForTermination value
		When User sends POST customers request with no ids and the following details
			| Field                | Value    |
			| GivenName            | Bob      |
			| FamilyName           | Customer |
			| IntroducedBy         | 99       |
			| PriorityGroups       | [1,3]    |
			| ReasonForTermination | 0        |
		Then User verifies the status code is "422"
		And Response should contain error
			| ErrorMessage                                 |
			| Please supply a valid Reason For Termination |

	@customers @validation
	Scenario: Post Customer where ReasonForTermination has value and DateOfTermination is not entered
		When User sends POST customers request with no ids and the following details
			| Field                | Value    |
			| GivenName            | Bob      |
			| FamilyName           | Customer |
			| IntroducedBy         | 99       |
			| PriorityGroups       | [1,3]    |
			| ReasonForTermination | 1        |
			| DateOfTermination    |          |
		Then User verifies the status code is "422"
		And Response should contain error
			| ErrorMessage                    |
			| Please enter a Termination Date |

	@customers @validation
	Scenario: Validate Customer Can't have 1 and 6 as PriorityGroups value at the same time
		When User sends POST customers request with no ids and the following details
			| Field          | Value    |
			| GivenName      | Bob      |
			| FamilyName     | Customer |
			| IntroducedBy   | 99       |
			| PriorityGroups | [1,6]    |
		Then User verifies the status code is "422"
		And Response should contain error
			| ErrorMessage                                     |
			| Can not be 18 to 24 and over 50 at the same time |