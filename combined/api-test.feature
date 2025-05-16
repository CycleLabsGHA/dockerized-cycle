Feature: API Test

Background:
If I verify file "combined/local.conf" exists
Then I assign values from config file "combined/local.conf" to variables
Else I assign values from config file "combined/api.conf" to variables
EndIf

Given I assign "https://ipapi.co" to variable "api_url"
Given I assign "https://maps.googleapis.com/maps/api/distancematrix/json" to variable "google_api_prefix"
Given I assign "https://maps.googleapis.com/maps/api/place/details/json" to variable "google_reviews_api_prefix"
Given I assign contents of variable "maps_api_key" to "google_api_key"
Given I assign "ChIJq_JOI1XDwogRnKcY6TbjeME" to variable "losgringos_placeid"


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
 	Then I assign variable "google_api_full_url" by combining $google_api_prefix "?destinations=place_id:" $losgringos_placeid "&origins=" $latitude "%20" $longitude "&units=imperial&key=" $google_api_key

Given I "construct the reviews API parameters"
    Then I assign variable "google_reviews_url" by combining $google_reviews_api_prefix "?place_id=" $losgringos_placeid "&fields=name,rating,user_ratings_total,reviews&key=" $google_api_key

Given I "query google API and parse JSON body to get usable data"
    Then I http GET JSON from $google_api_full_url
    Then I assign http response body to variable "google_api_return"
    Then I echo $google_api_return
    Then I execute Groovy script "combined/scripts/parse_json_body.groovy"

Given I "query Google API for reviews and parse JSON body to get usable data"
    Then I http GET JSON from $google_reviews_url
    Then I assign http response body to variable "google_reviews_return"
    Then I echo $google_reviews_return
    Then I execute Groovy script "combined/scripts/parse_google_reviews.groovy"

Given I "output time away from Los Gringos of West Tampa."
    Then I echo "Based on your IP address, you are in or close to " $city ", " $region "."
    Then I echo "Los Gringos of West Tampa."
    Then I echo "You are " $duration_of_trip " away from Los Gringos (and the best Cuban of Tampa)."

Given I "output Google review information for Los Gringos"
    # Then I echo $place_summary
    Then I echo "Here's what someone said:"
    Then I echo $top_review_text
