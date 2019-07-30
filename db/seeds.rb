Author.destroy_all
Book.destroy_all
Shelf.destroy_all
Shelfjoin.destroy_all
User.destroy_all


# seed data:
author1 = Author.create(name: "Steinbeck")
author2 = Author.create(name: "Jemisin")
author3 = Author.create(name: "Test")

user1 = User.create(name: "Trevor")
user2 = User.create(name: "Mia")

book1 = Book.create(title: "The Stone Sky", genre: "Fantasy")
author2.books << book1
book2 = Book.create(title: "East of Eden", genre: "Fiction")
author1.books << book2
book3 = Book.create(title: "Testtttt", genre: "Nonfiction")
author3.books << book3

shelf1 = Shelf.create(name: "Wishlist", description: "A list of all the books I want to read", user_id: user1.id)
shelf2 = Shelf.create(name: "Finished", description: "A list of all the books I have read", user_id: user2.id)
shelf3 = Shelf.create(name: "Finished", user_id: user2.id)

shelfjoin1 = Shelfjoin.create(shelf_id: shelf1.id, book_id: book1.id)