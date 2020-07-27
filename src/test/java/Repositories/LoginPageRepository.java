package Repositories;

import org.openqa.selenium.By;

public class LoginPageRepository {
	
	  public static By username=By.xpath("//input[@id='username']");
	  public static By password=By.xpath("//input[@id='password']");
	  public static By loginButton=By.xpath("//button[@class='radius']");
	  public static By error=By.xpath("//div[@class='flash error']");
	
}




