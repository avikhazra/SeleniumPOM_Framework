package Reports;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.io.FileHandler;
import org.testng.ITestContext;
import org.testng.ITestListener;
import org.testng.ITestResult;

import com.aventstack.extentreports.MediaEntityBuilder;
import com.aventstack.extentreports.Status;

import CommonLIB.GetBrowserElement;


public class TestListener  implements ITestListener  {
	@Override
	public void onTestStart(ITestResult result) {
		System.out.println(("*** Running test method " + result.getMethod().getMethodName() + "..."));
		ExtentTestReportManager.startTest(result.getMethod().getMethodName());
	}
	@Override
	public void onTestSuccess(ITestResult result) {
		System.out.println("*** Executed " + result.getMethod().getMethodName() + " test successfully...");

		// attach screenshots to report
		try {
			ExtentTestReportManager.getTest().addScreenCaptureFromPath(TakeScreenShot(result,"PASSED"));
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
		ExtentTestReportManager.getTest().log(Status.PASS, "Test passed");

	}

	@Override
	public void onTestFailure(ITestResult result) {
		System.out.println("*** Test execution " + result.getMethod().getMethodName() + " failed...");
		try {
			ExtentTestReportManager.getTest().fail("Screenshot",
					MediaEntityBuilder.createScreenCaptureFromPath(TakeScreenShot(result,"FAILED")).build());
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
		ExtentTestReportManager.getTest().log(Status.FAIL, "Test Failed");
	}



	@Override
	public void onTestSkipped(ITestResult result) {
		System.out.println("*** Test " + result.getMethod().getMethodName() + " skipped...");
		ExtentTestReportManager.getTest().log(Status.SKIP, "Test Skipped");

	}

	@Override
	public void onTestFailedButWithinSuccessPercentage(ITestResult result) {
		System.out.println("*** Test failed but within percentage % " + result.getMethod().getMethodName());

	}

	@Override
	public void onStart(ITestContext context) {
		System.out.println("*** Test Suite " + context.getName() + " started ***");

	}

	@Override
	public void onFinish(ITestContext context) {
		System.out.println(("*** Test Suite " + context.getName() + " ending ***"));
		ExtentTestReportManager.endTest();
		ExtentReportManager.getInstance().flush();

	}

	public static String TakeScreenShot(ITestResult result,String Name) {
		String targetLocation = null;
		String testClassName = (result.getInstanceName()).trim();
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat formater = new SimpleDateFormat("dd_MM_yyyy_hh_mm_ss");
		String timeStamp =formater.format(calendar.getTime()); // get timestamp
		String testMethodName = result.getName().toString().trim();
		String screenShotName = testMethodName+"_" + timeStamp+"_"+Name+ ".png";

		String reportsPath = System.getProperty("user.dir") + "/screenshots";
		try{
			File file = new File(reportsPath +"/"+testClassName); // Set
			// screenshots
			// folder
			if (!file.exists()) {
				if (file.mkdirs()) {
					System.out.println("Path created");
				} else {
					System.out.println("Path exists");
				}

			}

			File screenshotFile = ((TakesScreenshot) GetBrowserElement.getDriver()).getScreenshotAs(OutputType.FILE);
			targetLocation = reportsPath + "/" + testClassName + "/" + screenShotName;// define
			// location
			File targetFile = new File(targetLocation);

			FileHandler.copy(screenshotFile, targetFile);

		} catch (FileNotFoundException e) {
			System.out.println(e.toString());
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return targetLocation;
	}

}
