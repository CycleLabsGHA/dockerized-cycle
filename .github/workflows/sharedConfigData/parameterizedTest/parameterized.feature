Feature: Test with parameterized data

In this feature, the URL for the system under test has not been hard-coded in the
feature, but has been set in the default.conf file in this directory as:
grocer_url = "https://cyclelabs.io/playground"
grocer_url = ${?GROCER_URL}
With this syntax, the url would defult to https://cyclelabs.io/playground, but it
could be overwritten in a CI/CD pipeline to another value. An example where that
may be useful is maybe when developing the tests, you will be using a development
or QA site, but when running in the pipeline, you want to have the ability to run
against a different environment. You could set an environment variable to inject a
different URL into the test at runtime.

Background:
If I assign values from config file "sharedConfigData/parameterizedTest/local.conf" to variables
Elsif I assign values from config file "sharedConfigData/parameterizedTest/default.conf" to variables
EndIf

After Scenario:
If I close web browser
EndIf

Scenario: Login in with parameterized data
Given I open Chrome web browser
And I navigate to $grocer_url in web browser
# wait for the login screen to load
And I see element $loginPage_emailLabel in web browser within 10 seconds
When I type $username in element $loginPage_usernameField in web browser within 10 seconds
And I type $password in element $loginPage_passwordField in web browser within 10 seconds
And I click element $loginPage_loginButton in web browser
Then I do not see element $loginPage_loginButton in web browser within 10 seconds
