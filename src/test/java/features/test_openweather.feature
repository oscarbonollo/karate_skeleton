@OpenWeather
Feature: Using the API specification detailed in the URL above, develop the following tests:

  Background:
    ## set host url to http://api.openweathermap. from karate-config.js for all Scenarios
    * url openWeatherUrl

    * driver 'https://www.optus.com.au'
    * waitForUrl('https://www.optus.com.au')
    * click("a[href='/smartspaces']")
    * waitForUrl('smartspaces.optus.com.au')

  Scenario: 1. Validate that an invalid attempt to register a weather station without an API key will return 401 and the following in message body.
    ## also threw in a example of validating we get the response body expected. Seems they changed 'code' to 'cod' somewhere over time..
    Given path '/data/3.0/stations'
    * header Content-Type = 'application/json'
    And param appid = ''
    When method get
    Then status 401

    * driver 'https://www.optus.com.au'
    * waitForUrl('https://www.optus.com.au')
    * click("a[href='/smartspaces']")
    * waitForUrl('smartspaces.optus.com.au')

