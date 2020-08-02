package CommonLIB;



import java.util.concurrent.TimeUnit;

import org.openqa.selenium.*;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.testng.Assert;


public class CommonFunctionLib {
	public static  RemoteWebDriver driver;
	private static String previuosDomproperty=null;
	private static String AfterDomproperty=null;
	private static int i=0;
	/***********************************************************************
	 * Name :FocusOnUrl 
	 * Return type: void
	 * @throws Exception 
	 **********************************************************************/
	public  void FocusOnUrl(String strurl) throws Exception{
		GetBrowserElement.getJavascriptExecuter().executeScript("window.focus();");
		GetBrowserElement.getDriver().get(strurl);
		GetBrowserElement.getDriver().manage().timeouts().pageLoadTimeout(20, TimeUnit.SECONDS);
		GetBrowserElement.PageReadyStateCheck(3000);

	}
	/*******************************************************************
	 *  FunctionName: ClickObject
	 * Argument : WebElement
	 * @throws Exception 
	 * @throws IOException 
	 ********************************************************************/
	public void  ClickObject(WebElement ele) throws Exception{
		previuosDomproperty= GetBrowserElement.getDriver().getPageSource().toString();

		ele.click();
		GetBrowserElement.PageReadyStateCheck(3000);
		AfterDomproperty = GetBrowserElement.getDriver().getPageSource().toString();

		while(previuosDomproperty.equals(AfterDomproperty)){
			GetBrowserElement.getJavascriptExecuter().executeScript("arguments[0].click();", ele);
			AfterDomproperty="";
			AfterDomproperty = GetBrowserElement.getDriver().getPageSource().toString();
			if (i==3) {
				GetBrowserElement.getJavascriptExecuter().executeScript("arguments[0].click();", ele);
				previuosDomproperty=null;
				AfterDomproperty=null;
				i=0;
				Assert.assertTrue(false,"click on Object is failed");
				break;
			}
			i++;

		}			
		previuosDomproperty=null;
		AfterDomproperty=null;
		i=0;
	}




	/************************************************
	 * FunctionName: SetOnparam
	 * Argument :
	 * 
	 *************************************************/
	public void SetOnparam(WebElement element,String strtestdata)  {
		try {

			if (!strtestdata.equals("")) {
				element.click();
				element.clear();
				element.sendKeys(strtestdata);

				Assert.assertTrue(true,"Typing is Successfull");
			}else {

				Assert.assertTrue(false,"testdata is missing");
			}

		}catch(Exception ex) {

			Assert.assertTrue(false,"Exception is "+ ex.toString() + " for causing :" + ex.getMessage());
		}


	}	

	///New .....Code for testing Ninja Web Site

	/*******************************************
	 *  FunctionName: CheckCheckBox
	 * Argument : Xpath
	 * @throws InterruptedException 

	 *******************************************/
	public void CheckCheckBox(WebElement element, String Check_Uncheck) throws InterruptedException {

		boolean checkCondition;
		try {
			if(!Check_Uncheck.equalsIgnoreCase("")) {
				if (Check_Uncheck.equalsIgnoreCase("Check")){
					if (element.isSelected()) {
						Assert.assertTrue(false,"Element is already Checked. It can not be check again checking may causes Unchecking");
					}else {
						element.click();
						checkCondition=element.isSelected();
						GetBrowserElement.PauseExecution(100);
						if(checkCondition==true) {
							Assert.assertTrue(true,"Element is  Checked.");
						}else {
							element.sendKeys(Keys.SPACE);
							GetBrowserElement.PauseExecution(100);
							checkCondition=element.isSelected();
							if(checkCondition==true) {
								Assert.assertTrue(true,"Element is  Checked.");
							}else {
								Assert.assertTrue(true,"Element is not  Checked.");
							}
						}
					}

				}else if (Check_Uncheck.equalsIgnoreCase("unCheck")){
					if (!element.isSelected()) {
						Assert.assertTrue(false,"Element is already UnChecked. It can not be check again checking may causes Unchecking");
					}else {
						element.click();
						checkCondition=element.isSelected();
						GetBrowserElement.PauseExecution(100);
						if(checkCondition==false) {
							Assert.assertTrue(true,"Element is  UnChecked.");
						}else {
							element.sendKeys(Keys.SPACE);
							GetBrowserElement.PauseExecution(100);
							checkCondition=element.isSelected();
							if(checkCondition==false) {
								Assert.assertTrue(true,"Element is  UnChecked.");
							}else {
								Assert.assertTrue(false,"Element is not unChecked.");
							}
						}
					}


				}
			}else {
				Assert.assertTrue(false,"Check_Uncheck value cannot be blank");
			}

		}catch(Exception ex) {
			Assert.assertTrue(false,"Exception is "+ ex.toString() + " for causing :" + ex.getMessage());
		}


	}

	/******************************************
	 *  FunctionName: VerifyEnabilityCheck
	 * Argument :
	 * @throws IOException 
	 *******************************************/
	public void VerifyEnabilityCheck(WebElement element,String strtestdata)  {
		if (strtestdata.equals("")) {
			if (element.isEnabled()) {


				Assert.assertTrue(true, "Element is  Enabled.");	
			}else {

				Assert.assertTrue(false,"Element is not  Enabled.");	
			}	

		}else {
			if(strtestdata.equalsIgnoreCase("enable")||strtestdata.equalsIgnoreCase("disable")) {
				if(strtestdata.equalsIgnoreCase("enable")){
					if (element.isDisplayed()) {
						try {
							String AttributeVlaue = element.getAttribute("disabled");
							if (AttributeVlaue.equalsIgnoreCase("true")) {
								Assert.assertTrue(false,"Element is  not Enabled.and test data: "+strtestdata);
							}else {
								Assert.assertTrue(true,"Element is   Enabled.and test data: "+strtestdata);
							}
						}catch(Exception ex) {

						}		

					}else {
						Assert.assertTrue(false,"Element is  not Enabled.and test data: "+strtestdata);
					}

				}else {
					if (!element.isDisplayed()) {
						Assert.assertTrue(true, "Element is  not Enabled.and test data: "+strtestdata);	
					}else {
						try {
							String AttributeVlaue = element.getAttribute("disabled");
							if (AttributeVlaue.equalsIgnoreCase("true")) {
								Assert.assertTrue(true,"Element is  not Enabled.and test data: "+strtestdata);
							}else {
								Assert.assertTrue(false,"Element is   Enabled.and test data: "+strtestdata);
							}
						}catch(Exception ex) {

						}

					}
				}
			}else {
				Assert.assertTrue(false,"PLease check data");	
			}



		}

	}
}

