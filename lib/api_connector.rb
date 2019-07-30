require 'rest-client'
require 'json'
require 'pry'

# puts "Please enter a search term:"
# search_term = gets.chomp -- cli stuff, we don't want to call this every time we are getting data or looking up info from the api

def pull_from_api(search_term)
    string_response = RestClient.get("https://www.googleapis.com/books/v1/volumes?q=#{search_term}")
    response_hash = JSON.parse(string_response)
end


#google api search terms
# q - Search for volumes that contain this text string. There are special keywords you can specify in the search terms to search in particular fields, such as:
# intitle: Returns results where the text following this keyword is found in the title.
# inauthor: Returns results where the text following this keyword is found in the author.
# inpublisher: Returns results where the text following this keyword is found in the publisher.
# subject: Returns results where the text following this keyword is listed in the category list of the volume.
# isbn: Returns results where the text following this keyword is the ISBN number.
# lccn: Returns results where the text following this keyword is the Library of Congress Control Number.
# oclc: Returns results where the text following this keyword is the Online Computer Library Center number.