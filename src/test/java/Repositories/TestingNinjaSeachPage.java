package Repositories;

import org.openqa.selenium.By;

public class TestingNinjaSeachPage {
	public static By Searchinsubcategories =By.xpath("(//label[@class='checkbox-inline'])[1]/input");
	public static By Searchinproductdescriptions =By.xpath("(//label[@class='checkbox-inline'])[2]/input");
	public static By  SearchPage_Seach=By.xpath("//input[@id='button-search']");
	public static By ProductSelect=By.xpath("//img[@title='xxxx']/ancestor::a[1]/ancestor::div[1]/ancestor::div[1]/descendant::div[2]/descendant::div[2]/descendant::button[1]");
	public static By ProductValue=By.xpath("//div[@id='cart']/button[1]/span");
	public static By CheckOutButton=By.xpath("//div[@id='cart']/button[1]");
}
