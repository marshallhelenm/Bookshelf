require_relative '../config/environment'

test = "test"

book1 = Book.all.first
book2 = Book.all.second
book3 = Book.all.third
author1 = Author.all.first
author2 = Author.all.second
author3 = Author.all.third
user1 = User.all.first
user2 = User.all.second
shelf1 = Shelf.all.first
shelf2 = Shelf.all.second
shelf3 = Shelf.all.third
shelfjoin1 = Shelfjoin.all.first

binding.pry
puts test