class Author < ActiveRecord::Base
    has_many :books

    def number_of_books
        self.books.length
    end

    def number_of_shelves #number of shelves the author appears on
        collections = Shelf.all.map do |shelf|
        shelf.books
        end #getting an array of shelves where each shelf is an array of books
        relevant_collections = collections.select do |collection|
            collection.any?{ |book| book.author == self}
        end #keeping only those collections which contain one of the author's books
        relevant_collections.length
    end

    def number_of_users #number of users who have this author on their shelves
    end

    #methods to build
    #number of books
    #number of shelves they appear on
    #most popular author (highest num of shelves/users)
    #most prolific - requires published dates to be on books (stretch)
    #pseudonyms (if available)
end