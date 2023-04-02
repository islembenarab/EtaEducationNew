package formatec;

import org.junit.jupiter.api.Test;

import org.junit.runner.RunWith;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;


@DataJpaTest
@AutoConfigureTestDatabase
@RunWith(SpringRunner.class)
@ContextConfiguration(classes=Formatec1Application.class)
@SpringBootTest(
		classes = Formatec1Application.class,
		webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT
)
class Formatec1ApplicationTests {
	
	@Test
	void contextLoads() {
	}

}
