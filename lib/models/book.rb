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

    def Book.find_book_from_api(input) #search for a book in the api
        pull_from_api(input)
    end

    def Book.find_book
        puts "Please enter a book title:"
        title = gets.chomp
        puts "Please enter the author (or hit enter to skip):"
        author = gets.chomp
        #search for book in database
        #ask if it's the right one
        #if not found, search in api and create book (if not found in api, let the user know its not found)
        if author == ""
            search_term = "intitle+#{title}"
        else
            search_term = "intitle+#{title}+inauthor+#{author}"
        end
        Book.find_book_from_api(search_term) #this will return lots of stuff probably
        #check if book title actually contains all the wanted search terms
        #check for oldest published date
        binding.pry #in order to test this we are going to make an iteration to find earliest published date and try to find p&P&Z

        #if one result, present it and ask if it's right
        #if multiple results, present a few and ask if any are right


        
    end

end