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

    def Book.find_from_api(search_term) #search for a book in the api, returns top 5 results
        pull_from_api(search_term)
    end

    def Book.get_search_term
        puts "Please enter a book title:"
        title = gets.chomp
        puts "Please enter the author (or hit enter to skip):"
        author = gets.chomp
        if author == ""
            search_term = "intitle+#{title}"
        else
            search_term = "intitle+#{title}+inauthor+#{author}"
        end
        search_term
    end

    def Book.find_from_db(search_term)
        #find book from database
    end


    def Book.display_results(results)
        display_array = results.collect do |book|
            book["volumeInfo"]
        end
        display_array.each_with_index do |result, index|
            puts "#{index+1}."
            puts "Title: #{result["title"]}"
            puts "Author: #{result["authors"].join(", ")}"
            puts "Description: #{result["description"]}"
        end

    end

    def Book.confirm_book
            puts "Which number?"      
            book_num = gets.chomp.to_i #other stuff heeeeeere
    end

    def Book.find_book
        action = 0
        until action == 3 do
            search_term = Book.get_search_term
            book = Book.find_book_from_db(search_term)
            if book != nil #possibly not right, point is, if it found the book in the database
                #return book
                action = 3
            else #stuff to do if book not found in database
                results = Book.find_from_api(search_term)
                puts "Is it one of the below?"
                puts "1. Yes \n 2. No, search again \n 3. No, exit \n\n"
                display_results(results)
                action = gets.chomp.to_i
                if action == 1
                    book_num = Book.confirm_book
                    #create book instance & return it and 
                end
        end

    end

    

end