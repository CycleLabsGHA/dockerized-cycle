import groovy.json.JsonSlurper

json_to_parse = google_api_return

JsonSlurper slurper = new JsonSlurper()
parsed_json = slurper.parseText(json_to_parse)

duration_of_trip = parsed_json.rows.elements.duration.text as String
duration_of_trip = duration_of_trip.replace("[", "")
duration_of_trip = duration_of_trip.replace("]", "")