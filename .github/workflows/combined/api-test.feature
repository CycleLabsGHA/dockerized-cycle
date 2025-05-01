Feature: API Test

Background:
If I verify file "combined/local.conf" exists
Then I assign values from config file "combined/local.conf" to variables
Else I assign values from config file "combined/api.conf" to variables
EndIf

Given I assign "https://ipapi.co" to variable "api_url"
Given I assign "https://maps.googleapis.com/maps/api/distancematrix/json" to variable "google_api_prefix"
Given I assign contents of variable "maps_api_key" to "google_api_key"
Given I assign "ChIJFQomE5fzrIkRPNOtMwgYuaI" to variable "hnc_placeid"


Scenario: API Test
Given I "return my ip address"
	Then I assign variable "return_ip" by combining $api_url "/ip"
	Then I http get json from $return_ip
    Then I assign http response body to variable "ip"

Given I "return lat/long of my ip address"
	Then I assign variable "return_latitude" by combining $api_url "/latitude"
	Then I http get json from $return_latitude
    Then I assign http response body to variable "latitude"
    
    Then I assign variable "return_longitude" by combining $api_url "/longitude"
	Then I http get json from $return_longitude
    Then I assign http response body to variable "longitude"

    Then I assign variable "return_city" by combining $api_url "/city"
	Then I http get json from $return_city
    Then I assign http response body to variable "city"
    
    Then I assign variable "return_region" by combining $api_url "/region"
	Then I http get json from $return_region
    Then I assign http response body to variable "region"

    Then I echo $latitude $longitude
    
Given I "construct the API parameters"
 	Then I assign variable "google_api_full_url" by combining $google_api_prefix "?destinations=place_id:" $hnc_placeid "&origins=" $latitude "%20" $longitude "&units=imperial&key=" $google_api_key
    
Given I "query google API and parse JSON body to get usable data"
    Then I http GET JSON from $google_api_full_url
    Then I assign http response body to variable "google_api_return"
    Then I echo $google_api_return
    Then I execute Groovy script "combined/scripts/parse_json_body.groovy"

Given I "output time away from Himalayan Nepali Cuisine."
    Then I echo "Based on your IP address, you are in or close to " $city ", " $region "."
    Then I echo "Himalayan Nepali Cuisine is in Cary, North Carolina."
    Then I echo "You are " $duration_of_trip " away from Himalayan Nepali Cuisine."
