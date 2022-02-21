Build and Run using IntelliJ
-ea ./gradlew clean test -Dkarate.options"--tags @mytags classpath:features" -Dkarate.env=MyEnv

Build and run using Gradle (requires Gradle correctly installed on the local machine)
gradle clean test -Dkarate.options"--tags @OpenWeather classpath:features" -Dkarate.env=myEnv -i

Build and run using gradle wrapper (run in gitbash / terminal that can execute bash)
./gradlew clean test -Dkarate.options"--tags @OpenWeather classpath:features" -Dkarate.env=myEnv -i