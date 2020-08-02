package TestCases;

import org.testng.Assert;
import org.testng.annotations.*;

import com.codoid.products.exception.FilloException;


import CommonLIB.ExcelRead;
import CommonLIB.GetBrowserElement;
import CommonLIB.ObjectCreationClass;
import CommonLIB.TestNgFrameWorkBasic;
import Repositories.CommonRepository;

public class SeleniumByTestNG extends TestNgFrameWorkBasic  {

	@DataProvider
	public Object[][] getTestData() throws FilloException{
		Object data[][] = null;
		try {
		data = ExcelRead.ExtractDataWithFillo((System.getProperty("user.dir") + "/src/test/resources/Utils/testdatapertest1.xlsx"),"test1");
		//ExtractDataWithOutFillo-- Both can be use
		}catch(Exception ex) {
			Assert.assertTrue(false, ex.toString());
		}
		//System.out.println(data.length);
		return data;
	}
	
	@Test(dataProvider="getTestData")
	public void TestCases1(String username) throws Exception{
		ObjectCreationClass.ComLiB.FocusOnUrl(CommonRepository.StrtestUrl);
		ObjectCreationClass.HomePD.SearchProduct(username);
		ObjectCreationClass.SearchD.Select1stProduct();
		ObjectCreationClass.ChecKOut.AddtoCart();
		
	}
	
}













