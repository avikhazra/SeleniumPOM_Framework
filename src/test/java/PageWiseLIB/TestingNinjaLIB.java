package PageWiseLIB;

import org.openqa.selenium.By;
import org.testng.Assert;

import CommonLIB.GetBrowserElement;
import CommonLIB.ObjectCreationClass;

import Repositories.TestingNinjaHome;
import Repositories.TestingNinjaSeachPage;

public class TestingNinjaLIB {
	public void currencySelect(String Currency) throws Exception {
		GetBrowserElement.PageReadyStateCheck(5000);
		
		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(TestingNinjaHome.CurrencyDropDownFlag));
		GetBrowserElement.getWebElementByXpath(TestingNinjaHome.CurrencyDropDownSelect).findElement(By.xpath("//li/button[text()=\""+Currency+"\"]"));
			   GetBrowserElement.HighlisghtThexpath(GetBrowserElement.getWebElementByXpath(TestingNinjaHome.CurrencyDropDownSelect).findElement(By.xpath("//li/button[text()=\""+Currency+"\"]")));
			   ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(TestingNinjaHome.CurrencyDropDownSelect).findElement(By.xpath("//li/button[text()=\""+Currency+"\"]")));
		
	}
	
	public void SearchProduct(String Value) throws Exception {
		ObjectCreationClass.ComLiB.SetOnparam(GetBrowserElement.getWebElementByXpath(TestingNinjaHome.searchtype), Value);
		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(TestingNinjaHome.searchButton));
	}
	
	public void SearchProductWithDescriptionCatagory() throws Exception {
		ObjectCreationClass.ComLiB.CheckCheckBox(GetBrowserElement.getWebElementByXpath(TestingNinjaSeachPage.Searchinproductdescriptions),"check");
		ObjectCreationClass.ComLiB.VerifyEnabilityCheck(GetBrowserElement.getWebElementByXpath(TestingNinjaSeachPage.Searchinsubcategories),"disable");
		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(TestingNinjaSeachPage.SearchPage_Seach));
	}
	public void SelectNinjaProduct(String Value) throws Exception {
	//GetBrowserElement.HighlisghtThexpath(TestingNinjaSeachPage.ProductSelect);
	String products= TestingNinjaSeachPage.ProductSelect.toString();
	products=products.replace("xxxx", Value.toString());
	products=products.toString();
	System.out.println(products);
	GetBrowserElement.ScrollVieWObject(GetBrowserElement.getWebElementByXpath(By.xpath(products)));
	GetBrowserElement.HighlisghtThexpath(GetBrowserElement.getWebElementByXpath(By.xpath(products)));
	ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(By.xpath(products)));
	}
}
