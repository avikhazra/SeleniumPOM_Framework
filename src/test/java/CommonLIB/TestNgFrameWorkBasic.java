package CommonLIB;

import org.testng.annotations.*;

import Reports.TestListener;

public class TestNgFrameWorkBasic   {
	
	@BeforeSuite
	public void SetDataProvider() {
		
	}

	@BeforeTest
	@Parameters({ "browser","implicitWait" })
	public void BeforeTest(String browser,String implicitWait) {
		GetBrowserElement.BrowserLaunch(browser, implicitWait);
	}
	@BeforeMethod
	public void BeforeMethod() {
		System.out.println("New Testcase is started.... ");
	}
	@AfterMethod
	public void AfterMethod() {
		GetBrowserElement.getDriver().manage().deleteAllCookies();
		System.out.println("Testcase is Ended.... ");
	}
	
	@AfterTest
	public void TearDown() {
		GetBrowserElement.BrowserClosing();		
	}
	
	@AfterSuite
	public void Cleaning() {
		System.gc();
	}
}
