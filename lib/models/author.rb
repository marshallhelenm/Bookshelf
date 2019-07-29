class Author < ActiveRecord::Base
    has_many :books

    def number_of_books
        self.books.length
    end

    def number_of_shelves_author_appears_on
        collections = Shelf.all.map do |shelf|
        shelf.books
        end #getting an array of shelves where each shelf is an array of books
        collections.select do |collection|
            #this is not done
        end
    end

    #methods to build
    #number of books
    #number of shelves they appear on
    #most popular author (highest num of shelves/users)
    #most prolific - requires published dates to be on books (stretch)
    #pseudonyms (if available)
end