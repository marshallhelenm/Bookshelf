class Author < ActiveRecord::Base
    has_many :books

    #methods to build
    #number of books
    #number of shelves they appear on
    #most popular author (highest num of shelves/users)
    #most prolific - requires published dates to be on books (stretch)
    #pseudonyms (if available)
end