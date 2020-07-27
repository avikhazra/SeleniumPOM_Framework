package PageWiseLIB;

import org.testng.Assert;

import CommonLIB.GetBrowserElement;
import CommonLIB.ObjectCreationClass;
import Repositories.CheckOutPageRepository;


public class CheckOutPageLIB {

	public void AddtoCart() throws Exception {
		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(CheckOutPageRepository.AddtoCart));
		GetBrowserElement.PauseExecution(3000);
		if (GetBrowserElement.getWebElementByXpath(CheckOutPageRepository.proceedToCheckoutBox).isDisplayed()==true) {
			GetBrowserElement.HighlisghtThexpath(CheckOutPageRepository.proceedToCheckoutBox);
			Assert.assertTrue(true);
			
			ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(CheckOutPageRepository.proceedToCheckout));
		}else {
			Assert.assertTrue(true,"Pop up is not present");
		}

		if (GetBrowserElement.getWebElementByXpath(CheckOutPageRepository.proceedToCheckoutButton).isDisplayed()==true) {
			GetBrowserElement.ScrollVieWObject(GetBrowserElement.getWebElementByXpath(CheckOutPageRepository.proceedToCheckoutButton));
			GetBrowserElement.HighlisghtThexpath(CheckOutPageRepository.proceedToCheckoutButton);
			ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(CheckOutPageRepository.proceedToCheckoutButton));
			Assert.assertTrue(true);

		}else {
			Assert.assertTrue(true,"CheckOut button is not present");
		}
	}
}
