class Shelf < ActiveRecord::Base
    belongs_to :user
    has_many :sbjoins
    has_many :books, through: :sbjoins


    #methods to build:
    #books on shelf - should be inherent to the has_many statement - possibly
    #rename shelf
    #create/delete shelf - this is just built in
    #create shelf with random books of a genre or author or whatevs (stretch)
    #authors on shelf

    def rename(name)
        self.name = name
    end

    def authors
        authors = self.books.collect do |book|
            book.author
        end
        authors.uniq
    end
    
end