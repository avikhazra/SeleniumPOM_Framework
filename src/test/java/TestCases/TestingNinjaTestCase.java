package TestCases;

//import org.testng.Assert;
import org.testng.annotations.*;

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
	public void TestingNinjaTest1() throws Exception{
		ObjectCreationClass.ComLiB.FocusOnUrl(CommonRepository.testingInija);
		ObjectCreationClass.TN.currencySelect("£ Pound Sterling");
		GetBrowserElement.PageReadyStateCheck(3000);
		ObjectCreationClass.TN.SearchProduct("MacBook Air");
		ObjectCreationClass.ComLiB.ValidationText(GetBrowserElement.getWebElementByXpath(TestingNinjaSeachPage.PageNameShopping), "Search");
		ObjectCreationClass.TN.SearchProductWithDescriptionCatagory();
		ObjectCreationClass.TN.SelectNinjaProduct("MacBook Air");
		ObjectCreationClass.TN.productItemValidation("1");
		ObjectCreationClass.ComLiB.ValidationText(GetBrowserElement.getWebElementByXpath(TestingNinjaSeachPage.SuccessfullValue), "Success: You have added MacBook Air to your shopping cart!");
		ObjectCreationClass.TN.GotoCheckOutPage("MacBook Air");
		ObjectCreationClass.ComLiB.ValidationText(GetBrowserElement.getWebElementByXpath(TestingNinjaCheckOut.PageNameCheckout), "Checkout");
		ObjectCreationClass.TN.BeforeSelectionValidateRadioButtons();
		ObjectCreationClass.TN.SelectGuestCheckout();
		ObjectCreationClass.TN.AfterSelectionSelectGuestCheckout();
		
	}

}













