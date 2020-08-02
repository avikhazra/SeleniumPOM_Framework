package TestCases;

import org.testng.Assert;
import org.testng.annotations.*;

import com.codoid.products.exception.FilloException;


import CommonLIB.ExcelRead;
import CommonLIB.GetBrowserElement;
import CommonLIB.ObjectCreationClass;
import CommonLIB.TestNgFrameWorkBasic;
import Repositories.CommonRepository;

public class TestingNinjaTestCase extends TestNgFrameWorkBasic  {

	@Test
	public void TestingNinjaTest1() throws Exception{
		ObjectCreationClass.ComLiB.FocusOnUrl(CommonRepository.testingInija);
		ObjectCreationClass.TN.currencySelect("£ Pound Sterling");
		GetBrowserElement.PageReadyStateCheck(3000);
		ObjectCreationClass.TN.SearchProduct("MacBook Air");
		ObjectCreationClass.TN.SearchProductWithDescriptionCatagory();
		ObjectCreationClass.TN.SelectNinjaProduct("MacBook Air");
	}

}













