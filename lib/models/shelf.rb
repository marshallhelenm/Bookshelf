class Shelf < ActiveRecord::Base
    belongs_to :user
    has_many :shelfjoins
    has_many :books, through: :shelfjoins


    #methods to build:
    #books on shelf - should be inherent to the has_many statement - possibly
    #rename shelf
    #create/delete shelf - this is just built in
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

    def add_book(book)#accepts a book instance
        newjoin = Shelfjoin.new(shelf_id: self.id, book_id: book.id)
        book.shelfjoins << newjoin
        self.shelfjoins << newjoin
        #if no result, Book.create_from_api
        #if can't find in Google's database, return a message saying so
    end

    def add_book_by_name(book_name)
        #find or create book by name
        Book.all.find_by name: book_name
        #if no result, Book.create_from_api
        #if can't find in Google's database, return a message saying so
        #call add_book
    end
    
end