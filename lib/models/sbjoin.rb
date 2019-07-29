class SBJoin < ActiveRecord::Base
    has_many :books
    belongs_to :shelf
end 