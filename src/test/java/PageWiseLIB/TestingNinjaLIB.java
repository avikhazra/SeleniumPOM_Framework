package PageWiseLIB;

import org.openqa.selenium.By;
import org.testng.Assert;

import CommonLIB.GetBrowserElement;
import CommonLIB.ObjectCreationClass;
import Repositories.TestingNinjaCheckOut;
import Repositories.TestingNinjaHome;
import Repositories.TestingNinjaSeachPage;

public class TestingNinjaLIB {
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
		if(ObjectCreationClass.ComLiB.GetElementText(GetBrowserElement.getWebElementByXpath(TestingNinjaSeachPage.ProductValue)).contains(Value)) {
			Assert.assertTrue(true,"Validation is done");	
		}else {
			Assert.assertTrue(true,"Validation is failed");	
		}

	}

	public void GotoCheckOutPage(String Value) throws Exception {
		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(TestingNinjaSeachPage.CheckOutButton));
		GetBrowserElement.PageReadyStateCheck(1000);
		ObjectCreationClass.ComLiB.ValidationText(GetBrowserElement.getWebElementByXpath(TestingNinjaSeachPage.ProductName),Value);
		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(TestingNinjaSeachPage.CheckOutLink));
	}
	
	
	public void BeforeSelectionValidateRadioButtons() throws Exception {
		GetBrowserElement.PageReadyStateCheck(1000);
		ObjectCreationClass.ComLiB.RadioButtonStatusChecking(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.RegisterAccount),true);
		ObjectCreationClass.ComLiB.RadioButtonStatusChecking(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.GuestCheckout),false);
	}
	public void SelectGuestCheckout() throws Exception {
		ObjectCreationClass.ComLiB.SelectRadioButton(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.GuestCheckout));
	}
	public void AfterSelectionSelectGuestCheckout() throws Exception {
		ObjectCreationClass.ComLiB.RadioButtonStatusChecking(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.RegisterAccount),false);
		ObjectCreationClass.ComLiB.RadioButtonStatusChecking(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.GuestCheckout),true);
	}
}
