Feature: Professors list API 
  In order to reference professors
  As an API client
  I want to be able to request professors via a JSON API 

  Scenario: Get professors
    Given Get professors list
    When I ask for professors from the API "/professors"
    Then The response code should be 200
    And The JSON response should be an array with professors elements