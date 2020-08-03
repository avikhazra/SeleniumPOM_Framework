package Repositories;

import org.openqa.selenium.By;

public class TestingNinjaCheckOut {
	public static By CheckOutButton=By.xpath("//div[@id='cart']/button[1]");
	public static By CheckOutLink=By.xpath("//strong[text()=' Checkout']/ancestor::a");
	
	public static By GuestCheckout=By.xpath("//input[@name='account' and @value='guest']");
	public static By RegisterAccount=By.xpath("//input[@name='account' and @value='register']");
	public static By PageNameCheckout=By.xpath("//ul[@class='breadcrumb']/li[3]/a[1]");
	public static By ContinueButton =By.xpath("//label[text()[normalize-space()='Guest Checkout']]/following::input");
	public static By FName=By.xpath("//input[@placeholder='First Name']");
	public static By LName=By.xpath("//input[@placeholder='Last Name']");
	public static By email=By.xpath("(//input[@name='email'])[2]");
	public static By telephone= By.xpath("//input[@placeholder='Telephone']");
	public static By Address1= By.xpath("//input[@placeholder='Address 1']");
	public static By city = By.xpath("//input[@placeholder='City']");
	public static By postCode= By.xpath("//input[@placeholder='Post Code']");
	public static By CountryDropdown=By.xpath("//label[text()='Country']/following-sibling::select");
	public static By stateDropDown =By.xpath("//label[text()='Region / State']/following-sibling::select");
	public static By ShippingAddressCheckbox = By.xpath("//input[@name='shipping_address']");
	public static By BillingAddressGuestContinue= By.xpath("(//input[@value='Continue'])[2]");
	public static By DeliveryMethod= By.xpath("//label[text()[normalize-space()='Flat Shipping Rate - 3.92€']]/following::textarea");
	public static By DeliveryContinue=By.xpath("//label[text()[normalize-space()='Flat Shipping Rate - 3.92€']]/following::input");
	public static By guestPaymentMethod=By.xpath("//label[text()[normalize-space()='Cash On Delivery']]/following::textarea");
	public static By guestPaymentMethodTermsCondition=By.xpath("//label[text()[normalize-space()='Cash On Delivery']]/following::input");
	public static By guestPaymentMethodContinue=By.xpath("//input[@type='checkbox']/following-sibling::input[1]");
	public static By ConfirmOrdername=By.xpath("//table[contains(@class,'table table-bordered')]/following::table");
	public static By ConfirmOrder=By.xpath("(//label[text()[normalize-space()='Cash On Delivery']]/following::input)[3]");
	public static By Confirmation=By.xpath("//div[@id='content']//h1[1]");
}