#Main Menu Option 5

#find book on the book model returns a book instance, pass that into book_action_menu
def found_book_action_menu(book)
    menu = <<-MENU
    1. Add this book to a shelf
    2. Exit to Menu
    MENU
    puts menu
    action = STDIN.gets.chomp.to_i
end

#found book menu returns an action, pass that and the book instance here
def found_book_action(book, action, active_user)
    if action == 1
        shelf = choose_shelf(active_user)
        shelf.add_book_to_shelf(book)
    end
end