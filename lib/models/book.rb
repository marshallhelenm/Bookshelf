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

    def Book.get_search_terms
        puts "Please enter a book title:"
        title = gets.chomp
        puts "Please enter the author (or hit enter to skip):"
        author = gets.chomp
        return [author, title]
    end
    
    def get_author(author_name)
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
            book.title.downcase.include?(title) || book.get_author(author_name).name.downcase.include?(author_name)
        end
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
            terms = Book.get_search_terms
            search_term = format_search_term(terms)
            book = Book.find_book_from_db(terms)
            if book != nil #possibly not right, point is, if it found the book in the database
                book #return book
                action = 3
            else #stuff to do if book not found in database
                results = Book.grab_data_from_api(search_term)
                puts "Is it one of the below?"
                puts "1. Yes \n 2. No, search again \n 3. No, exit \n\n"
                display_results(results)
                action = gets.chomp.to_i
                if action == 1
                    book_num = Book.confirm_book
                    #then create book instance & return it and 
                end
            end
        end

    end

    def Book.create_from_api(book_data)
        #takes in api data for a book
        #adds a book to the database using api info
        #assigns an author, and creates one if needed
       
        #author biz:
        #search for author:
        auth_inst = Author.all.find do |author|
            author.name == book_data["volumeInfo"]["authors"][0]
        end        
        if auth_inst == nil
            auth_inst = Author.create(name: book_data["volumeInfo"]["authors"][0])
        end
         #create book instance:
         book = Book.create(title: book_data["volumeInfo"]["title"], api_url: book_data["selfLink"], author_id: auth_inst.id)
    end

    
    
    #methods for testing purposes
    
    def Book.get_random_book(book_array) #book array will need to be made up of search terms
        books = book_array.map do |search_term|
            pull_one_from_api(search_term)
        end.flatten
        books.each do |book|
            binding.pry
            Book.create(title: book["volumeInfo"]["title"], api_url: book["selfLink"])
        end
    end
    

end