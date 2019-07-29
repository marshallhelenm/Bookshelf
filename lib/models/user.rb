class User < ActiveRecord::Base
    has_many :shelves
    has_many :books, through: :shelves

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