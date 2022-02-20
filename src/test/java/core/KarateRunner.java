package core;
import com.intuit.karate.junit5.Karate;

class KarateRunner {

    @Karate.Test
    Karate runFeatures() {
        return Karate.run("classpath:").tags();
    }

}