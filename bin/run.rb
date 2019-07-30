require_relative '../config/environment'

test = "test"

# seed data:
# author1 = Author.create(name: "Steinbeck")
# author2 = Author.create(name: "Jemisin")
# author3 = Author.create(name: "Test")

# user1 = User.create(name: "Trevor")
# user2 = User.create(name: "Mia")

# book1 = Book.create(title: "The Stone Sky", genre: "Fantasy")
# book2 = Book.create(title: "East of Eden", genre: "Fiction")
# book3 = Book.create(title: "Testtttt", genre: "Nonfiction")

# shelf1 = Shelf.create(name: "Wishlist", description: "A list of all the books I want to read", user_id: user1.id)
# shelf2 = Shelf.create(name: "Finished", description: "A list of all the books I have read", user_id: user2.id)
# shelf3 = Shelf.create(name: "Finished", user_id: user2.id)

# shelfjoin1 = Shelfjoin.create(shelf_id: shelf1.id, book_id: book1.id)

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