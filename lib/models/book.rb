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

    def Book.grab_data_from_api(search_term) #search for a book in the api, returns top 5 results
        pull_from_api(search_term)
    end

    def Book.create_from_api(book_data)
        #takes in api data for a book
        #adds a book to the database using api info
        #assigns an author, and creates one if needed
    
        #search for author:
        auth_inst = Author.all.find do |author|
            author.name == book_data["volumeInfo"]["authors"][0]
        end        
        if auth_inst == nil
            auth_inst = Author.create(name: book_data["volumeInfo"]["authors"][0])
        end
        
         #create book instance:
         book = Book.create(title: book_data["volumeInfo"]["title"], api_url: book_data["selfLink"], author_id: auth_inst.id, description: book_data["volumeInfo"]["description"])
    end

    def Book.get_search_terms
        puts "Please enter a book title:"
        title = STDIN.gets.chomp
        puts "Please enter the author (or hit enter to skip):"
        author = STDIN.gets.chomp
        return [author, title]
    end
    
    def Book.format_search_term(terms) #takes array of author and title
        author = terms[0]
        title = terms[1]
        if author == ""
            search_term = "intitle+#{title}"
        else
            search_term = "#{author}+intitle+#{title}"
        end
        search_term
    end

    def get_author_by_name(author_name)
        author_instance = Author.all.find do |author|
            author.name.downcase.include?(author_name.downcase)
        end 
        author_instance
    end

    def Book.find_from_db(terms)
        #terms is an array of author name and book title
        #find book from database
        author_name = terms[0].downcase
        title = terms[1].downcase
        book = Book.all.find do |book| 
            book.title.downcase.include?(title) && book.author.name.downcase.include?(author_name)
        end
    end


    def Book.display_results(results)
        display_array = results.collect do |book|
            book["volumeInfo"]
        end
        display_array.each_with_index do |result, index|
            puts "\n#{index+1}. Title: #{result["title"]}"
            if result["authors"]
                puts "  Author: #{result["authors"].join(", ")}"
                puts "\n    Description: #{result["description"]}"
            else
                puts "\n    Description: #{result["description"]}"
            end
        end
    end

    def display_db_book_info
        info = <<-INFO
    \n
    Title: #{self.title}
    Author: #{self.author.name}\n
    Description: #{self.description}\n
    INFO
        puts info
    end

    def Book.confirm_book(results)
            puts "Which number?"  
            book_num = 0 
            until book_num <= results.length && book_num > 0
                book_num = STDIN.gets.chomp.to_i #other stuff heeeeeere
                unknown_command unless book_num <= results.length && book_num >= 0
            end
            book_num
    end


    ####################FIND BOOK######################

    def Book.find_book
        action = 0
        until action == 3 do
            terms = Book.get_search_terms #grab search terms from user input
            search_term = format_search_term(terms) #format search term for use in api search
            book = Book.find_from_db(terms) #check for book in the database
            if book #if successfully found the book in the database do the below
                book.display_db_book_info
                puts "Is this the right book?"
                puts <<-TXT
    1. Yes
    2. No, search again
    3. No, exit \n\n
    TXT
                action = STDIN.gets.chomp.to_i
                return book if action == 1
            else #stuff to do if book not found in database
                results = Book.grab_data_from_api(search_term) #use the search term to pull data from the API
                # display the results in a user friendly way and ask the user for an action
                Book.display_results(results)
                puts ""
                puts "Is it one of the above?"
                puts <<-TXT
    1. Yes
    2. No, search again
    3. No, exit
                TXT
                action = STDIN.gets.chomp.to_i
                if action == 1 #pick book and create instance then return book
                    book_index = Book.confirm_book(results) - 1 #ask the user to tell us which book is the right one (the number they indicated will be one higher than that books data index)
                    book = Book.create_from_api(results[book_index]) #create book instance based on the api data for the indicated book 
                    return book
                end
            end
        end

    end




    
    
    # #methods for testing purposes
    
    # def Book.get_random_book(book_array) #book array will need to be made up of search terms
    #     books = book_array.map do |search_term|
    #         pull_one_from_api(search_term)
    #     end.flatten
    #     books.each do |book|
    #         binding.pry
    #         Book.create(title: book["volumeInfo"]["title"], api_url: book["selfLink"])
    #     end
    # end
    

end