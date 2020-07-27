package CommonLIB;

import org.testng.annotations.*;

import Reports.TestListener;

public class TestNgFrameWorkBasic extends ExcelRead  {
	
	@BeforeSuite
	public void SetDataProvider() {
		
	}

	@BeforeTest
	@Parameters({ "browser","implicitWait" })
	public void BeforeTest(String browser,String implicitWait) {
		GetBrowserElement.BrowserLaunch(browser, implicitWait);
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
