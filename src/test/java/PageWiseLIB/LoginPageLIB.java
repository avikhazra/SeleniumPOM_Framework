package PageWiseLIB;
import CommonLIB.GetBrowserElement;
import CommonLIB.ObjectCreationClass;

import Repositories.LoginPageRepository;

public class LoginPageLIB extends HHomePageLIB {
	
	public void userInfo(String name, String pwd) throws Exception {
		
		ObjectCreationClass.ComLiB.SetOnparam(GetBrowserElement.getWebElementByXpath(LoginPageRepository.username), name);
		ObjectCreationClass.ComLiB.SetOnparam(GetBrowserElement.getWebElementByXpath(LoginPageRepository.password), pwd);
		
		ObjectCreationClass.ComLiB.ClickObject(GetBrowserElement.getWebElementByXpath(LoginPageRepository.loginButton));		
		
		//validation	
		if (GetBrowserElement.getWebElementByXpath(LoginPageRepository.error).isDisplayed()==true) {				
				System.out.println("test case fail");				
			}else {
				System.out.println("test case pass");
		
	}
}}
