class Book < ActiveRecord::Base
    belongs_to :author

    #methods to build:
    #get author
    #users who have saved this book
    #get infodump on book (add more properties that the API has)
    
    #class method - book appearing on the most shelves (most popular book)

end