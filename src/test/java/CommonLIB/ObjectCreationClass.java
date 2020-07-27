package CommonLIB;

import PageWiseLIB.CheckOutPageLIB;
import PageWiseLIB.FacebookPageLIB;
import PageWiseLIB.HHomePageLIB;
import PageWiseLIB.HomePageLIB;
import PageWiseLIB.LoginPageLIB;
import PageWiseLIB.SearchDeatailsPageLIB;

public class ObjectCreationClass extends TestNgFrameWorkBasic{
	 public static CommonFunctionLib ComLiB = new CommonFunctionLib(); // common
	 
	 //HomePge- first TC
	 public static HomePageLIB HomePD= new HomePageLIB();
	 public static SearchDeatailsPageLIB SearchD= new SearchDeatailsPageLIB();	 
	 public static CheckOutPageLIB ChecKOut= new CheckOutPageLIB();
	 
	 //HHomePage- second TC
	 public static HHomePageLIB HomePD1= new HHomePageLIB();	 
	 public static LoginPageLIB log= new LoginPageLIB();
	 
	 //faCebook page- third TC
	 public static FacebookPageLIB fc= new FacebookPageLIB();
}
