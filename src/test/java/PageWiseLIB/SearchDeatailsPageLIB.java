package PageWiseLIB;


import CommonLIB.GetBrowserElement;
import CommonLIB.ObjectCreationClass;
import Repositories.SearchResultPageRepository;

public class SearchDeatailsPageLIB {
	
	public void Select1stProduct() throws Exception {
		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(SearchResultPageRepository.Select1StProduct));
		GetBrowserElement.PageReadyStateCheck(1000);
	}
}
