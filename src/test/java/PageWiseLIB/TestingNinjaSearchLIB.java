package PageWiseLIB;

import org.openqa.selenium.By;
import org.testng.Assert;


import CommonLIB.GetBrowserElement;
import CommonLIB.ObjectCreationClass;
import Repositories.TestingNinjaCheckOut;
import Repositories.TestingNinjaHome;
import Repositories.TestingNinjaSeachPage;

public class TestingNinjaSearchLIB {
	
	public void SearchProductWithDescriptionCatagory() throws Exception {
		ObjectCreationClass.ComLiB.CheckCheckBox(GetBrowserElement.getWebElementByXpath(TestingNinjaSeachPage.Searchinproductdescriptions),"check");
		ObjectCreationClass.ComLiB.VerifyEnabilityCheck(GetBrowserElement.getWebElementByXpath(TestingNinjaSeachPage.Searchinsubcategories),"disable");
		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(TestingNinjaSeachPage.SearchPage_Seach));
	}

	public void SelectNinjaProduct(String Value) throws Exception {
		String ReplacedXpath=ObjectCreationClass.ComLiB.ReplacedXpath(TestingNinjaSeachPage.ProductSelect,"xxxx",Value);
		GetBrowserElement.ScrollVieWObject(GetBrowserElement.getWebElementByXpath(By.xpath(ReplacedXpath)));
		//GetBrowserElement.HighlisghtThexpath(GetBrowserElement.getWebElementByXpath(By.xpath(ReplacedXpath)));
		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(By.xpath(ReplacedXpath)));
		GetBrowserElement.PageReadyStateCheck(1000);

	}
public void productItemValidation(String Value) {
		
		ObjectCreationClass.ComLiB.ValidationText(GetBrowserElement.getWebElementByXpath(TestingNinjaSeachPage.ProductValue),Value);
	}

	
}
