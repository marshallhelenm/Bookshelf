class Shelf < ActiveRecord::Base
    has_many :sbjoins
    has_many :books, through: :sbjoins

    #methods to build:
    #books on shelf
    #create/delete shelf
    #create shelf with random books of a genre or author or whatevs (stretch)
    #authors on shelf
    
end