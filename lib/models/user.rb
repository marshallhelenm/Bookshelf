class User < ActiveRecord::Base
    has_many :shelves
    has_many :books, through: :shelves
end