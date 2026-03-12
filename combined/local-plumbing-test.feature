Feature: Local Plumbing Test

Background:
  After Scenario:
    If I close web browser
    Endif

Scenario Outline: Verify Cycle to Chrome/Edge to Mock App connectivity
  Given I open <browser> web browser on remote <remoteUrl>
  When I navigate to "http://webapp" in web browser
  Then I see "Local Test Page" in web browser within 5 seconds
  And I see "your browser container reached the local web server" in web browser
  
  Then I click element "id:test-button" in web browser
  And I see "Button clicked!" in web browser within 15 seconds

Examples:
| browser | remoteUrl |

| "Chrome" | "http://chrome:4444/wd/hub" |

| "Edge" |  "http://edge:4444/wd/hub" |

# | "Firefox" | "http://firefox:4446/wd/hub" |
