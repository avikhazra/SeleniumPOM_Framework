package TestCases;

import org.testng.annotations.Test;

import CommonLIB.ObjectCreationClass;
import Repositories.CommonRepository;

public class HeroTest {
	
	@Test()
	public void TestCases2() throws Exception{
		ObjectCreationClass.ComLiB.FocusOnUrl(CommonRepository.url1);
		
		ObjectCreationClass.HomePD1.formAuthent();	// calling homepage
		ObjectCreationClass.log.userInfo("abcde", "12345");	 //username/ passwrd passed to LoginpageLIB
		
	}
}

	
	


