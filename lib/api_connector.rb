require 'rest-client'
require 'json'
require 'pry'

# puts "Please enter a search term:"
# search_term = gets.chomp -- cli stuff, we don't want to call this every time we are getting data or looking up info from the api

def pull_from_api(search_term)
    string_response = RestClient.get("https://www.googleapis.com/books/v1/volumes?q=#{search_term}")
    response_hash = JSON.parse(string_response)
end