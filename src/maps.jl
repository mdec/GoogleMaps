using JSON, Requests
include("apikey.jl")
#include("types.jl")

function callGeocodeAPI(
    url::String)

    rawResponse = get(url)
    parsedResponseData = JSON.parse(rawResponse.data)

    return(parsedResponseData)
end

function changeSpaceToPlus!(
    str::String)

    str = replace(str, r" +", "+")
    return(str)
end

function extractGeocodeInfo(
    geocodeResponse::Dict{String, Any})

    location = geocodeResponse["results"][1]["geometry"]["location"]
    center = LatLng(location["lat"], location["lng"])

    name = geocodeResponse["results"][1]["formatted_address"]

    info = Geocode(center, name)
    return(info)
end

function getGeocodeURL(
    address::String)

    url = "https://maps.googleapis.com/maps/api/geocode/json?address=$address&sensor=false&key=$apikey"
    return(url)
end

function geocode(
    zip::Int)

    zipString = string(zip)
    geocodeResults = geocode(zipString)
    return(geocodeResults)
end

function geocode(
    address::String)

    address = changeSpaceToPlus!(address)
    geocodeURL = getGeocodeURL(address)
    geocodeResponse = callGeocodeAPI(geocodeURL)
    geocodeResults = extractGeocodeInfo(geocodeResponse)
    return(geocodeResults)
end

function getMap(
    center::LatLng,
    zoom::Int)


end
