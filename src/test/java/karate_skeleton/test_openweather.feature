@OpenWeather
Feature: Using the API specification detailed in the URL above, develop the following tests:

  Background:
    * def apiKey = read('apikey')
    * url openWeatherUrl
    #openWeatherUrl can be provided if we wish to use a global URL from the karate-config.js

  Scenario: 1. Validate that attempt to register a weather station without an API key will return the following in message body.
    Given path '/data/3.0/stations'
    * header Content-Type = 'application/json'
    And param appid = ''
    When method get
    Then status 401
    Then match response ==
    """
    {"cod":401,"message":"Invalid API key. Please see http:\/\/openweathermap.org\/faq#error401 for more info."}
    """

