package PageWiseLIB;


import org.openqa.selenium.By;

import CommonLIB.GetBrowserElement;
import CommonLIB.ObjectCreationClass;
import Repositories.TestingNinjaCheckOut;

import Repositories.TestingNinjaSeachPage;

public class TestingNinjaCheckoutLIB {


	public void GotoCheckOutPage(String Value) throws Exception {
		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.CheckOutButton));
		GetBrowserElement.PageReadyStateCheck(1000);
		ObjectCreationClass.ComLiB.ValidationText(GetBrowserElement.getWebElementByXpath(TestingNinjaSeachPage.ProductName),Value);
		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.CheckOutLink));
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
	
	public void BillingAddress(String Fname,String Lname,String email, String Phone,String Address,String City,String Country,String State) throws Exception {
		ObjectCreationClass.ComLiB.SetOnparam(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.FName), Fname);
		ObjectCreationClass.ComLiB.SetOnparam(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.LName), Lname);
		ObjectCreationClass.ComLiB.SetOnparam(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.email), email);
		ObjectCreationClass.ComLiB.SetOnparam(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.telephone), email);
		ObjectCreationClass.ComLiB.SetOnparam(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.Address1), Address);
		ObjectCreationClass.ComLiB.SetOnparam(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.city), City);
		ObjectCreationClass.ComLiB.selectOnparam(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.CountryDropdown), Country);
		ObjectCreationClass.ComLiB.selectOnparam(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.stateDropDown), State);
		ObjectCreationClass.ComLiB.CheckCheckBox(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.ShippingAddressCheckbox), "check");
		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.BillingAddressGuestContinue));
		
	}
}
