package PageWiseLIB;
import CommonLIB.GetBrowserElement;
import CommonLIB.ObjectCreationClass;
import Repositories.HomepageRepository;

public class HomePageLIB {

	public void SearchProduct(String testdata) throws Exception {
		ObjectCreationClass.ComLiB.SetOnparam(GetBrowserElement.getWebElementByXpath(HomepageRepository.searchBar), testdata);
		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(HomepageRepository.searchButton));
		GetBrowserElement.PageReadyStateCheck(3000);
	}

}
