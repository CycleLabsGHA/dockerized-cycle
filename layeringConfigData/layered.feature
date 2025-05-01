Feature: Layered Data

In this example, we have a default.conf file which contains test data for creating
a new order in the grocer.io application. The default test data includes an order 
number, a customer name, and a price in USD. We also have ca.conf, euro.conf, and
yuan.conf the include the data from default.conf but overrides the price data in
other currencies. The env.conf contains a setting which controls which of these conf
files are loaded, so which currency is used when the test runs. It has a default
value of euro.conf. It also includes the login credentials and locators. If we ran
the test as is, the order would be created in euros.  There is also the ability to
create a local.conf file which includes env.conf and then overrides the envFile entry
so that a different currency is used in the test. Alternatively, we can inject an
ENV_FILE environement variable to specify a different currency at run time, which
may be very useful if running the test in a pipeline. In that type of setup, we
could easily switch between currencies without having to change any of the files
in the project.

Background: Open browser and login
# load credentials, web locators, and env data
If I assign values from config file "layeringConfigData/local.conf" to variables
Elsif I assign values from config file "layeringConfigData/env.conf" to variables
EndIf
And I assign values from config file $envFile to variables

Given I open Chrome web browser
And I navigate to $grocer_url in web browser
# wait for the login screen to load
And I see element $loginPage_emailLabel in web browser within 10 seconds
When I type $username in element $loginPage_usernameField in web browser within 10 seconds
And I type $password in element $loginPage_passwordField in web browser within 10 seconds
And I click element $loginPage_loginButton in web browser
Then I do not see element $loginPage_loginButton in web browser within 10 seconds

After Scenario:
If I close web browser
EndIf

Scenario: Enter order
Given I see element $orderPage_title in web browser within 10 seconds
And I click element $orderPage_addOrderButton in web browser within 10 seconds
Once I see $addOrderModal_title in web browser

When I type $customer_name in element $addOrderModal_customerField in web browser within 10 seconds
And I type $order_number in element $addOrderModal_orderNumberField in web browser within 10 seconds
And I type $price in element $addOrderModal_priceField in web browser within 10 seconds
And I click element $addOrderModal_addButton in web browser within 10 seconds
Once I do not see element $addOrderModal_addButton in web browser
		
Then I see $order_number in web browser within 10 seconds
And I see $customer_name in web browser within 10 seconds
And I see $price in web browser within 10 seconds