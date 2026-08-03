package bdd;

        import com.intuit.karate.junit5.Karate;

public class TestRunner {

    @Karate.Test
    Karate testLogin() {
        return Karate.run("classpath:bdd/auth/loginAuth.feature");
    }

    @Karate.Test
    Karate testRegister() {
        return Karate.run("classpath:bdd/auth/registerAuth.feature");
    }
}