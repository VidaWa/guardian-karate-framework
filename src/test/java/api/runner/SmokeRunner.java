package api.runner;

import com.intuit.karate.junit5.Karate;

public class SmokeRunner {
	
	@Karate.Test
	public Karate runTest() {
		// address for the feature files.
		// And tags.
		return Karate.run("classpath:features").tags("@Smoke");
	}

}
