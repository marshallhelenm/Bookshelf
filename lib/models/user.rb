class User < ActiveRecord::Base
    has_many :shelves

    #custom initialize that includes creating shelves? everyone should start with a wishlist shelf and a read books shelf


    def add_book(shelf, book)
        shelf.add_book(book)
    end

    def add_book_by_name(shelf, book_name)
        shelf.add_book_by_name
    end

    
    #methods to build:
    #create a shelf
    #delete a shelf
    #rename a shelf (stretch?)
    #add book to shelf
    #remove book from shelf
    #list all books from a shelf
    #list all books from all shelves
    #count books read
    #list all users/names
    #most-read author (stretch)
    #authors on shelves
    #read authors
    
end