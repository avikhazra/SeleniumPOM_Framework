package PageWiseLIB;

import org.openqa.selenium.By;
import org.testng.Assert;


import CommonLIB.GetBrowserElement;
import CommonLIB.ObjectCreationClass;
import Repositories.TestingNinjaCheckOut;
import Repositories.TestingNinjaHome;
import Repositories.TestingNinjaSeachPage;

public class TestingNinjaHomeLIB {
	public void currencySelect(String Currency) throws Exception {
		GetBrowserElement.PageReadyStateCheck(5000);

		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(TestingNinjaHome.CurrencyDropDownFlag));
		GetBrowserElement.getWebElementByXpath(TestingNinjaHome.CurrencyDropDownSelect).findElement(By.xpath("//li/button[text()=\""+Currency+"\"]"));
		//GetBrowserElement.HighlisghtThexpath(GetBrowserElement.getWebElementByXpath(TestingNinjaHome.CurrencyDropDownSelect).findElement(By.xpath("//li/button[text()=\""+Currency+"\"]")));
		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(TestingNinjaHome.CurrencyDropDownSelect).findElement(By.xpath("//li/button[text()=\""+Currency+"\"]")));

	}

	public void SearchProduct(String Value) throws Exception {
		ObjectCreationClass.ComLiB.SetOnparam(GetBrowserElement.getWebElementByXpath(TestingNinjaHome.searchtype), Value);
		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(TestingNinjaHome.searchButton));
	}
}
