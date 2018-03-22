Feature: Locations

  As a user
  I want to get latitude and longitude of an address

  Scenario: Get latitude and longitude of an address
    When I perform get request to the locations endpoint with address query params
    Then I should see a valid response
    And The JSON response should be valid