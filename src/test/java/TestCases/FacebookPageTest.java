package TestCases;

import org.testng.annotations.Test;

import CommonLIB.ObjectCreationClass;
import Repositories.CommonRepository;

public class FacebookPageTest {
	
	@Test()
	public void TestCases3() throws Exception{
		ObjectCreationClass.ComLiB.FocusOnUrl(CommonRepository.url2);
		
		/*LoginPage.dd4(loginPage.month_dropDown, "Aug");
		LoginPage.dd4(loginPage.day_dropDown, "8");
		LoginPage.dd4(loginPage.year_dropDown, "2018");*/
		
		ObjectCreationClass.fc.dropDown();
		ObjectCreationClass.fc.dropDown();
		ObjectCreationClass.fc.dropDown();	
		
	}

}
