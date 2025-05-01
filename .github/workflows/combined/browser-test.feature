Feature: Web Driver Test

After Scenario: 
If I close web browser
Endif

Scenario Outline: Test all browser packages
Given I open <browser> web browser on remote <remoteUrl>
When I navigate to "https://cyclelabs.io" in web browser
Then I see "Warehouse Management Systems" in web browser within 15 seconds

Examples:
| browser | remoteUrl |

| "Chrome" | "http://chrome:4444/wd/hub" |

| "Edge" |  "http://edge:4444/wd/hub" |

# | "Firefox" | "http://firefox:4446/wd/hub" |
