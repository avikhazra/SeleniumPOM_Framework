package Repositories;

import org.openqa.selenium.By;

public class TestingNinjaCheckOut {
	public static By GuestCheckout=By.xpath("//input[@name='account' and @value='guest']");
	public static By RegisterAccount=By.xpath("//input[@name='account' and @value='register']");
	public static By PageNameCheckout=By.xpath("//ul[@class='breadcrumb']/li[3]/a[1]");
}
