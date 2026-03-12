Feature: Local Plumbing Test

Background:
  After Scenario:
    If I close web browser
    Endif

Scenario: Verify Cycle to Chrome to Mock App connectivity
  Given I open "Chrome" web browser on remote "http://chrome:4444/wd/hub"
  When I navigate to "http://webapp" in web browser
  Then I see "Local Test Page" in web browser within 5 seconds
  And I see "your browser container reached the local web server" in web browser
  
  When I click "test-button" in web browser
  Then I see "Button clicked!" in web browser
