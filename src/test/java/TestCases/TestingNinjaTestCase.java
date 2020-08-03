package TestCases;



import org.testng.annotations.Test;

//import com.codoid.products.exception.FilloException;


//import CommonLIB.ExcelRead;
import CommonLIB.GetBrowserElement;
import CommonLIB.ObjectCreationClass;
import CommonLIB.TestNgFrameWorkBasic;
import Repositories.CommonRepository;
import Repositories.TestingNinjaCheckOut;
import Repositories.TestingNinjaSeachPage;

public class TestingNinjaTestCase extends TestNgFrameWorkBasic  {

	@Test
	public void TestingNinja_Product_guest_book_Test1() throws Exception{
		ObjectCreationClass.ComLiB.FocusOnUrl(CommonRepository.testingInija);
		ObjectCreationClass.TN.currencySelect("£ Pound Sterling");
		GetBrowserElement.PageReadyStateCheck(3000);
		ObjectCreationClass.TN.SearchProduct("MacBook Air");
		ObjectCreationClass.ComLiB.ValidationText(GetBrowserElement.getWebElementByXpath(TestingNinjaSeachPage.PageNameShopping), "Search");
		ObjectCreationClass.TNS.SearchProductWithDescriptionCatagory();
		ObjectCreationClass.TNS.SelectNinjaProduct("MacBook Air");
		ObjectCreationClass.ComLiB.ValidationText(GetBrowserElement.getWebElementByXpath(TestingNinjaSeachPage.SuccessfullValue), "Success: You have added MacBook Air to your shopping cart!");
		ObjectCreationClass.TNS.productItemValidation("1");
		ObjectCreationClass.TNC.GotoCheckOutPage("MacBook Air");
		ObjectCreationClass.ComLiB.ValidationText(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.PageNameCheckout), "Checkout");
		ObjectCreationClass.TNC.BeforeSelectionValidateRadioButtons();
		ObjectCreationClass.TNC.SelectGuestCheckout();
		ObjectCreationClass.TNC.AfterSelectionSelectGuestCheckout();
		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.ContinueButton));
		ObjectCreationClass.TNC.BillingAddress("John", "Doe", "john.doe@gmail.com", "112345", "112 Now Where","1234567", "XXXX", "Congo", "Pool");
		ObjectCreationClass.TNC.DeliveryMethod("Cash");
		ObjectCreationClass.TNC.GuestPaymentMethod("Cash on Delivery");
		ObjectCreationClass.TNC.confirmOrder("MacBook Air");		
	}
	@Test
	public void TestingNinja_Product_guest_book_DropDownValidation_Canada_Test2() throws Exception{
		ObjectCreationClass.ComLiB.FocusOnUrl(CommonRepository.testingInija);
		ObjectCreationClass.TN.currencySelect("$ US Dollar");
		GetBrowserElement.PageReadyStateCheck(3000);
		ObjectCreationClass.TN.SearchProduct("Samsung SyncMaster 941BW");
		ObjectCreationClass.ComLiB.ValidationText(GetBrowserElement.getWebElementByXpath(TestingNinjaSeachPage.PageNameShopping), "Search");
		ObjectCreationClass.TNS.SearchProductWithDescriptionCatagory();
		ObjectCreationClass.TNS.SelectNinjaProduct("Samsung SyncMaster 941BW");
		ObjectCreationClass.ComLiB.ValidationText(GetBrowserElement.getWebElementByXpath(TestingNinjaSeachPage.SuccessfullValue), "Success: You have added MacBook Air to your shopping cart!");
		ObjectCreationClass.TNS.productItemValidation("1");
		ObjectCreationClass.TNC.GotoCheckOutPage("Samsung SyncMaster 941BW");
		ObjectCreationClass.ComLiB.ValidationText(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.PageNameCheckout), "Checkout");
		ObjectCreationClass.TNC.BeforeSelectionValidateRadioButtons();
		ObjectCreationClass.TNC.SelectGuestCheckout();
		ObjectCreationClass.TNC.AfterSelectionSelectGuestCheckout();
		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.ContinueButton));
		ObjectCreationClass.ComLiB.selectOnparam(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.CountryDropdown), "Canada");
		ObjectCreationClass.ComLiB.VerifyDropdownContains(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.stateDropDown), " --- Please Select --- |Alberta|British Columbia|Manitoba|New Brunswick|Newfoundland and Labrador|Northwest Territories|Nova Scotia|Nunavut|Ontario|Price Edward Island|Québec|Saskatchewan|Yukon Territory");
		ObjectCreationClass.TNC.BillingAddress("John", "Doe", "john.doe@gmail.com", "112345", "112 Now Where","1234567", "XXXX", "Canada", "Ontario");
		ObjectCreationClass.TNC.DeliveryMethod("Cash");
		ObjectCreationClass.TNC.GuestPaymentMethod("Cash on Delivery");
		ObjectCreationClass.TNC.confirmOrder("Samsung SyncMaster 941BW");		
	}

}













