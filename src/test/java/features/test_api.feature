@TestAPI
Feature: Test the OpenWeather API

  Background:
    ## set host url to http://api.openweathermap. from karate-config.js for all Scenarios
    * url openWeatherUrl

  Scenario: API1 Validate that an invalid attempt to register a weather station without an API key will return 401 and the following in message body.
    ## also threw in a example of validating we get the response body expected. Seems they changed 'code' to 'cod' somewhere over time..
    Given path '/data/3.0/stations'
    * header Content-Type = 'application/json'
    And param appid = ''
    When method get
    Then status 401
    Then match response ==
    """
    {
      "cod":401,
      "message": "Invalid API key. Please see https://openweathermap.org/faq#error401 for more info."
    }
    """

  Scenario: API2 - Successfully register two stations with the following details and verify that HTTP response code is 201
    ## because ID appears to be dynamic on POST response we assign the ID of the GET to response.ID
    ## we then fire off a GET response with the ID appended to the webservice URL and validate status code 200 returned against the ID
    ## if the GET fails it means the ID does not exist or an incorrect ID was passed
    Given path '/data/3.0/stations'
    And param appid = '6f5d1b3245cf1af1cd0a68971607f193'
    * header Content-Type = 'application/json'
    * def post_payload = read('post_demo_001.json')
    And request post_payload
    When method post
    Then status 201
    Then match response ==
    """
    {"altitude":222,"updated_at":#string,"user_id":"6212263ec1c1ef0007fadcb8","latitude":33.33,"name":"Team Demo Test Station 001","created_at":#string,"rank":10,"external_id":"DEMO_TEST001","source_type":5,"ID":#string,"longitude":-122.43}
    """
    * def returnedID = response.ID
    Then path '/data/3.0/stations/' + returnedID
    And param appid = '6f5d1b3245cf1af1cd0a68971607f193'
    When method get
    Then status 200

  Scenario: API3 - Successfully register two stations with the following details and verify that HTTP response code is 201
    ## Same scenario as 2a. but with a different station ID and values
    ## This time we will read and store the POST response values in variables then assert dynamically against the GET Response Body
    Given path '/data/3.0/stations'
    And param appid = '6f5d1b3245cf1af1cd0a68971607f193'
    * header Content-Type = 'application/json'
    * def post_payload = read('post_demo_002.json')
    And request post_payload
    When method post
    Then status 201
    Then match response ==
    """
    {"altitude":111,"updated_at":#string,"user_id":"6212263ec1c1ef0007fadcb8","latitude":44.44,"name":"Team Demo Test Station 002","created_at":#string,"rank":10,"external_id":"DEMO_TEST002","source_type":5,"ID":#string,"longitude":-122.44}
    """
    * def returnedID = response.ID
    * def returnedName = response.name
    * def returnedAltitude = response.altitude
    * def returnedLatitude = response.latitude
    * def returnedLongitude = response.longitude
    Then path '/data/3.0/stations/' + returnedID
    And param appid = '6f5d1b3245cf1af1cd0a68971607f193'
    When method get
    Then status 200
    Then match response ==
    """
    {
      "altitude":#(returnedAltitude),
      "updated_at":#string,
      "latitude":#(returnedLatitude),
      "name":#(returnedName),
      "created_at":#string,
      "rank":10,
      "external_id":"DEMO_TEST002",
      "id":#(returnedID),
      "longitude":#(returnedLongitude),
    }
    """