class Shelf < ActiveRecord::Base
    has_many :sbjoins
    has_many :books, through: :sbjoins
end