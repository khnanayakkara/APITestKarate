import com.intuit.karate.junit5.Karate;

class TestRunner {

    @Karate.Test
    Karate testPets() {
        return Karate.run("classpath:features/pets.feature").tags("@pets");
    }
}
