package PageWiseLIB;

import CommonLIB.GetBrowserElement;
import CommonLIB.ObjectCreationClass;
import Repositories.HHomePageRepository;

public class HHomePageLIB extends ObjectCreationClass{

	public void formAuthent() throws Exception {
		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(HHomePageRepository.formAuthenticationlink));		
	}}
