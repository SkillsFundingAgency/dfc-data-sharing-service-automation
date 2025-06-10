Feature: DSS Collections

  @happy_path
  Scenario: GET multiple (valid request)
    When User sends GET collections request with no ids
    Then User verifies the status code is "200"
  
  Scenario: GET multiple (invalid; no API key)
    When User sends GET collections request with no ids and without api key
    Then User verifies the status code is "401"
  
  Scenario: GET multiple (invalid; no touchpoint id)
    When User sends GET collections request with no ids and without touchpoint id
    Then User verifies the status code is "400"

  Scenario: GET multiple (invalid; no api version)
    When User sends GET collections request with no ids and without api version
    Then User verifies the status code is "404"