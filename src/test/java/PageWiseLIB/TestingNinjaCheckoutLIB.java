package PageWiseLIB;


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
}
