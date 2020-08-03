package CommonLIB;

import PageWiseLIB.CheckOutPageLIB;
import PageWiseLIB.FacebookPageLIB;
import PageWiseLIB.HerokuupHomePageLIB;
import PageWiseLIB.HomePageLIB;

import PageWiseLIB.LoginPageLIB;
import PageWiseLIB.SearchDeatailsPageLIB;
import PageWiseLIB.TestingNinjaCheckoutLIB;
import PageWiseLIB.TestingNinjaHomeLIB;
import PageWiseLIB.TestingNinjaSearchLIB;


public class ObjectCreationClass {
	 public static CommonFunctionLib ComLiB = new CommonFunctionLib(); // common
	 
	 //HomePge- first TC
	 public static HomePageLIB HomePD= new HomePageLIB();
	 public static SearchDeatailsPageLIB SearchD= new SearchDeatailsPageLIB();	 
	 public static CheckOutPageLIB ChecKOut= new CheckOutPageLIB();
	 
	 //HHomePage- second TC
	 public static HerokuupHomePageLIB HomePD1= new HerokuupHomePageLIB();	 
	 public static LoginPageLIB log= new LoginPageLIB();
	 
	 //faCebook page- third TC
	 public static FacebookPageLIB fc= new FacebookPageLIB();
	 
	 //Testing Nija
	 public static TestingNinjaHomeLIB TN= new TestingNinjaHomeLIB();
	 public static TestingNinjaSearchLIB TNS= new TestingNinjaSearchLIB();
	 public static TestingNinjaCheckoutLIB TNC= new TestingNinjaCheckoutLIB();
}
