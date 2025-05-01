Feature: Utilize a combination of config files

In this example, we'll pull together pieces from the secrets, parameterizedTest, and
layeringConfigData examples and illustrate how we can have a simple yet dynamic
test with cleanly separated and easy to maintain data, which includes credentials,
locators for the system under test, and test data. The locators will be stored in
the pageObjects.conf file.  The credentials will be stored in a credentials.conf
file, or rather the environment variables referenced will be configured there so
that passwords are not committed to the project files. The default.conf, ca.conf, 
euro.conf, and yuan.conf file will be used to structure the dynamic test data.
Finally, the env.conf file will include the credentials and the pageObjects, as well
as reference the default test data. We can optionally create a local.conf to 
override any values locally, or inject values via environment variables. By
combining these into one env.conf, optionally overwritten by a local.conf, we can
make this test very dynamic while only needing a few easy to read and maintain steps,
so that the business process being tested still remains clear and distinguishable
from the test data.

Background: Open browser and login
# load credentials, web locators, and env data
If I assign values from config file "sharedConfigData/combined/local.conf" to variables
Elsif I assign values from config file "sharedConfigData/combined/env.conf" to variables
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
