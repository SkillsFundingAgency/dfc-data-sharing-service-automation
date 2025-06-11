Feature: DSS Collections

  @happy_path @collections
  Scenario: GET multiple (valid request)
    When User sends GET collections request with no ids
    Then User verifies the status code is "200"