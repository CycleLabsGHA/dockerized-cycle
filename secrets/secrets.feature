Feature: Using conf files to handle secrets

This feature demonstrates using a .conf file to handle secrets in a feature.
The recommended setup is to add local.conf to your .gitignore file, so that they
are never committed to your git repository. The user name and password in this
example are not hard-coded in your project.  In a default.conf file, we have 
added the following entries:
username = ${GROCER_USER}
password = ${GROCER_PASS}
so that when running this feature in a CI/CD pipeline, these values can be injected
by your secret manager. When running locally, you can store your actual values in
a local.conf file to run the test locally. Alternatively, you could use a .bat file locally
to pull secrets from a secret manager prior to launching Cycle to avoid the use of a local.bat file.

Background:
If I assign values from config file "secrets/local.conf" to variables
Elsif I assign values from config file "secrets/default.conf" to variables
EndIf

After Scenario:
If I close web browser
EndIf

Scenario: Login with injected secrets
Given I open Chrome web browser
And I navigate to "https://cyclelabs.io/playground" in web browser
# wait for the login screen to load
And I see element "text:Email" in web browser within 10 seconds
When I type $username in element "name:email_login" in web browser within 10 seconds
And I type $password in element "xPath://input[@type='password']" in web browser within 10 seconds
And I click element "text:Login" in web browser
Then I do not see element "text:Login" in web browser within 10 seconds
