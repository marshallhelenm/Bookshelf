class Shelf < ActiveRecord::Base
    belongs_to :user
    has_many :shelfjoins
    has_many :books, through: :shelfjoins


    #methods to build:
    #books on shelf - should be inherent to the has_many statement - possibly
    #rename shelf
    #create shelf with random books of a genre or author or whatevs (stretch)
    #authors on shelf

    def rename(name)
        self.name = name
        self.save
    end

    def authors
        authors = self.books.collect do |book|
            book.author
        end
        authors.uniq
    end

    def remove_book_from_shelf(book)
        connection = Shelfjoin.all.find do |join|
            shelf_id == shelf.id && book_id == book.id
        end
        connection.delete
    end

    def add_book_to_shelf(book)#accepts a book instance - so this is really a helper method
        self.books << book
        self.save
        puts "\nYou have successfully added #{book.title} to your shelf #{self.name}.\n"
        puts "Shelf contents: "
        self.view_shelf_contents
    end

    def view_shelf_contents
        if self.books.empty?
            puts "\n\nYou don't have any books on this shelf yet!\n\n" 
        else
            puts `clear`
            puts "\n#{self.name}:\n\n"
            self.books.each_with_index do |book, index|
                puts "#{index + 1}. #{book.title} by #{book.author.name}"
            end
            puts "\n"
        end 
    end

    def edit_description(description)
        self.description = description
        self.save
    end

    # def add_book_by_name(book_name)
    #     #find or create book by name
    #     newbook = Book.all.find_by name: book_name
    #     self.add_book(newbook)
    #     #if no result, Book.create_from_api
    #     #if can't find in Google's database, return a message saying so
    #     #call add_book
    # end
    
    


end