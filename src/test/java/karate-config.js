function fn() {
  var env = karate.env; // get system property 'karate.env'

  if (!env) {
    env = 'myEnv';

  }

  var config = {
    env: env,
    baseUrl: '',
    openWeatherUrl: '', //initialise the url we wish to use
  }
  if (env == 'myEnv') {
    config.openWeatherUrl = 'http://api.openweathermap.org'

  } else if (env == 'dev') {
    config.openWeatherUrl = '';
  }
  return config;
}