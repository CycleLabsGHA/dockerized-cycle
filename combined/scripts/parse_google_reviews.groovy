import groovy.json.JsonSlurper

def json = new JsonSlurper().parseText(google_reviews_return)

// Extract name, rating, and reviews
def placeName = json.result.name
def rating = json.result.rating
def totalRatings = json.result.user_ratings_total
def reviews = json.result.reviews

// Example: Print summary info
println "Place Name: ${placeName}"
println "Rating: ${rating} (${totalRatings} total ratings)"
println "Top Review: ${reviews[0]?.text ?: 'No reviews'}"

// Optionally store values back into Cycle variables
place_summary = "${placeName} has a ${rating}-star rating from ${totalRatings} users"
top_review_text = reviews[0]?.text
