package Repositories;

import org.openqa.selenium.By;

public class CheckOutPageRepository {

	public static By AddtoCart=By.xpath("//p[@id='add_to_cart']/button[@name='Submit']/span");
	public static By proceedToCheckoutBox=By.xpath("//span[@class='cross']");
    public static By proceedToCheckout=By.xpath("//span[normalize-space(text()) = 'Proceed to checkout']");
	public static By  proceedToCheckoutButton=By.xpath("//a[contains(@class,'button btn')]/span[1]");
	
		
}




