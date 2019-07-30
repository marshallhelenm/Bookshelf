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

# Book.find_book

book_array = ["intitle+earthsea+inauthor+le+guin", "intitle+mansfield+park+inauthor+jane+austen"]
# book_array << Book.format_search_term("author", "title")
book_array << Book.format_search_term("Steinbeck", "East of Eden")
book_array << Book.format_search_term("Melville", "Moby Dick")
book_array << Book.format_search_term("Tolstoy", "War And Peace")
book_array << Book.format_search_term("Homer", "The Odyssey")
book_array << Book.format_search_term("Marquez", "One Hundred Years of Solitude")
book_array << Book.format_search_term("Dostoyevsky", "Brothers Karamazov")
book_array << Book.format_search_term("Homer", "Iliad")
book_array << Book.format_search_term("Dostoyevsky", "Crime And Punishment")
    
binding.pry
puts test