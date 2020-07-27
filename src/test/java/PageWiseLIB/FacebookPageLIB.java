package PageWiseLIB;
import org.openqa.selenium.WebElement;

import CommonLIB.GetBrowserElement;
import CommonLIB.ObjectCreationClass;
import Repositories.FacebookPageRepository;

public class FacebookPageLIB extends ObjectCreationClass {
	
	public void dropDown(WebElement name, String value) throws Exception{
	ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(FacebookPageRepository.month),);
	//Select m = new Select(month);
	//m.selectByVisibleText("May");	
	}
}




