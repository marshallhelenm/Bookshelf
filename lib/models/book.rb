class Book < ActiveRecord::Base
    belongs_to :author
    has_many :shelfjoins
    has_many :shelves, through: :shelfjoins


    # def initialize(author_name)
    #     @author_id = #find or create author by author_name, and grab its id
    # end

    #methods to build:
    #get author -- don't need we can just access this
    #get infodump on book (add more properties that the API has)
    
    #class method - book appearing on the most shelves (most popular book)

    def shelf_joins
        #gives a list of shelf join instances
        SBJoin.all.select do |sbjoin|
            sbjoin.book_id == self
        end
    end

    def shelf_ids
        self.shelf_joins.collect do |join|
            shelf_id
        end #getting an array of ids for shelves that hold this book
    end

    def shelves
        #iterate through all shelves
        #only grab at shelves that are connected to this book by a shelf id

        shelf_instances = Shelf.all.select do |shelf|
            self.shelf_ids.include?(shelf.id)
        end
        shelf_instances
    end

    def users
        users = self.shelves.collect do |shelf|
          shelf.user  
        end
        users.uniq
    end

    def self.create_from_api
        #stuff goes here
    end

end