require_relative '../config/environment'

test = "test"

author1 = Author.new("Steinbeck")
author2 = Author.new("Jemisin")
author3 = Author.new("Test")

user1 = User.new("Trevor")
user2 = User.new("Mia")

book1 = Book.new(title: "The Stone Sky", genre: "Fantasy")
book2 = Book.new(title: "East of Eden", genre: "Fiction")
book3 = Book.new(title: "Testtttt", genre: "Nonfiction")

shelf1 = Shelf.new(name: "Wishlist", description: "A list of all the books I want to read", user_id: user1.id)
shelf2 = Shelf.new(name: "Finished", description: "A list of all the books I have read", user_id: user2.id)

sbjoin1 = SBJoin.new(shelf_id: shelf1.id, book_id: book1.id)


puts test