package CommonLIB;


import java.util.List;
import java.util.concurrent.TimeUnit;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.*;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.FluentWait;
import org.openqa.selenium.support.ui.Wait;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;

import com.google.common.base.Predicate;
public class GetBrowserElement   {
	private static RemoteWebDriver driver;
	/***********************************************************************
	 * Name : BrowserLaunch
	 * @return  as WebDriver
	 * ReturnType: Webdriver
	 * 
	 * 
	 ***********************************************************************/
	public static void BrowserLaunch(String browser,String implicitWait) {	
	if(browser.equalsIgnoreCase("chrome")) {
    System.setProperty("webdriver.chrome.driver",System.getProperty("user.dir")+ "/src/test/resources/Utils/chromedriver.exe");
   ChromeOptions chromeOptions = new ChromeOptions();
   chromeOptions.setPageLoadStrategy(PageLoadStrategy.NORMAL);
	driver = new ChromeDriver(chromeOptions);
	driver.manage().window().maximize();
	driver.manage().deleteAllCookies();
	}
	driver.manage().timeouts().implicitlyWait(Integer.parseInt(implicitWait),TimeUnit.SECONDS);
	}	

	/***********************************************************************
	 * Name : BrowserClosing
	 * @return 
	 * ReturnType: void
	
	 ***********************************************************************/

	public static  void BrowserClosing() {
		
		driver.close();
		driver.quit();

	}
	/***********************************************************************
	 * Name : getDriver
	 * @return 
	 * ReturnType: WebDriver
	
	 ***********************************************************************/

	public static WebDriver getDriver() {

		return driver;

	}
	/***********************************************************************
	 * Name : getJavascriptExecuter
	 * @return 
	 * ReturnType: WebDriver
	
	 ***********************************************************************/

	public static JavascriptExecutor getJavascriptExecuter() {
		JavascriptExecutor js = (JavascriptExecutor) driver;
		return js;

	}
	
		/***********************************************************************
	 * Name : getWebElementByXpath
	 * @return 
	 * ReturnType: WebElement
	
	 ***********************************************************************/

	public static WebElement getWebElementByXpath (By xpath) {
		List<WebElement>ele=driver.findElements(xpath);
		if (ele!=null) {
			return ele.get(0);
			
		}else {
			Assert.assertTrue(false, "Element not Found!"); // Here you can use custom exception
		}
        return null;
	}
	/**************************************************************
	 *  FunctionName: WaitforElementToReturn
	 * Argument : intmilisecond, string
	 * Return: WebElement
	 ***************************************************************/
	public static WebElement WaitforElementToReturn(By xpath, int intsecond) {
		WebElement element=null;
		try {
			PageReadyStateCheck(intsecond);
			Wait<WebDriver> wait = new FluentWait<WebDriver>(driver)
					.withTimeout(intsecond, TimeUnit.SECONDS)
					.pollingEvery(5, TimeUnit.SECONDS)
					.ignoring(NoSuchElementException.class);
		}catch(Exception ex) {}
	try {
		
		    WebDriverWait wait = new WebDriverWait(driver,intsecond);
			element = wait.until(ExpectedConditions.visibilityOf(getWebElementByXpath(xpath)));//(strxpath));//());//(driver.findElement(strxpath)));
		} catch(Exception ex) {
			element= null;	
			System.out.println("element   : is null");
		}
		return element;	
	}
	/***********************************************
	 *  FunctionName: PageReadyStateCheck
	 * Argument : intmilisecond
	 * @return 
	 * @throws InterruptedException 
	 * 
	 *************************************************/
	public static void PageReadyStateCheck(int intmilisecond) throws Exception {
		final JavascriptExecutor js = (JavascriptExecutor)driver;
		try {
			WebDriverWait wait = new WebDriverWait(driver,intmilisecond);
			
			
			
			wait.until(new ExpectedCondition<Boolean>(){

				public Boolean apply(WebDriver driver) {
					
					
					try {
					
						Thread.sleep(1000);
					
					} catch (InterruptedException e) {
					}
					return js.executeScript("return document.readyState").equals("complete");
				}
			});
			
			
			
			
			
			wait.until(new ExpectedCondition<Boolean>(){

				public Boolean apply(WebDriver driver) {

					while(true) {
						if((Boolean) js.executeScript("return jQuery.active==0")) {
							
							break;
						}
						try {
							Thread.sleep(1000);
						}catch(Exception ex) {
						}
					}
					return true;
				}
			});
			while((!js.executeScript("return document.readyState").equals("complete"))) {
				Thread.sleep(1000);
			}
			
			PauseExecution(1000);
		}catch(Exception ex) {
			
		}
	}
	/***************************************************************
	 *  FunctionName: PauseExecution
	 * Argument :TestData
	 * @throws InterruptedException 
	 * 
	 * 
	 ****************************************************************/
	public static void PauseExecution(int pausedtime) throws InterruptedException {
		long starttime,Endtime;
		Thread.sleep(2000);
		starttime = System.currentTimeMillis();
		do {
			Thread.sleep(100);
			Endtime= System.currentTimeMillis();

		}while(Endtime-starttime<pausedtime);
	}
	
	/***********************************************************
	 *  FunctionName: HighlisghtThexpath
	 * Argument : Xpath
	 **********************************************************/
	public  static void  HighlisghtThexpath(By strxpath){
	
		JavascriptExecutor js = (JavascriptExecutor) driver;
		try {
			List<WebElement>element = driver.findElements(strxpath);
			for(WebElement ele: element) {
				js.executeScript("arguments[0].setAttribute('style', 'border: 3px solid red;');", ele);
				Thread.sleep(2000);
			}
		}catch(Exception ex) {
			Assert.assertTrue(false,"Exception is "+ ex.toString() + " for causing :" + ex.getMessage());
		}

	}
	/***********************************************************
	 *  FunctionName: HighlisghtThexpath
	 * Argument : WebElemnt
	 * Overloading
	 **********************************************************/
	public  static void  HighlisghtThexpath(WebElement ele){
	
		JavascriptExecutor js = (JavascriptExecutor) driver;
		try {
			
			
				js.executeScript("arguments[0].setAttribute('style', 'border: 3px solid red;');", ele);
				Thread.sleep(2000);
			
		}catch(Exception ex) {
			Assert.assertTrue(false,"Exception is "+ ex.toString() + " for causing :" + ex.getMessage());
		}

	}
	/*************************************************
	 *  FunctionName: ScrollVieWObject
	 * Argument : WebElement
	 * @throws IOException 
	 ***************************************************/
	public static  void  ScrollVieWObject( WebElement ele) {
		try {
			GetBrowserElement.getJavascriptExecuter().executeScript("arguments[0].scrollIntoView();", ele);
			Assert.assertTrue(true,"Scrolled Perfectly");
		}catch(Exception ex) {}
	}
	
}
