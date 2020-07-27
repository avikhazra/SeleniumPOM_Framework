package TestCases;

import org.testng.annotations.Test;

import CommonLIB.ObjectCreationClass;
import CommonLIB.TestNgFrameWorkBasic;
import Repositories.CommonRepository;

public class HeroTest extends TestNgFrameWorkBasic{
	
	@Test()
	public void TestCases2() throws Exception{
		ObjectCreationClass.ComLiB.FocusOnUrl(CommonRepository.url1);
		
		ObjectCreationClass.HomePD1.formAuthent();	// calling homepage
		ObjectCreationClass.log.userInfo("abcde", "12345");	 //username/ passwrd passed to LoginpageLIB
		
	}
}

	
	


