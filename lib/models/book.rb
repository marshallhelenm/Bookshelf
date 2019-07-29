class Book < ActiveRecord::Base
    belongs_to :author

    #methods to build:
    #get author -- don't need we can just access this
    #users who have saved this book 
    #get infodump on book (add more properties that the API has)
    
    #class method - book appearing on the most shelves (most popular book)

    def shelf_joins
        #gives a list of shelf join instances
        SBJoin.all.select do |sbjoin|
            sbjoin.book_id == self
        end
    end

    def shelves
        #iterate through all shelves
        #only grab at shelves that are connected to this book by a shelf id
        Shelf.all.select do |shelf|
            shelf_joins.collect do |sbjoin|
                sbjoin.shelf_id = shelf.id
            end
        end
    end

    def users
        # User.all.select do |user|
        #     user.
        # end
    end

end