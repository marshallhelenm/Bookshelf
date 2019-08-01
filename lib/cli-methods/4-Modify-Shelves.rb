#Main Menu Option 4

def menu_option_four(active_user)
    to_menu = false
    until to_menu == true
        action = menu_four #(shows menu and gets action)
        to_menu = menu_four_perform(action, active_user)
    end 
end

def menu_four
    menu = <<-MENU
        Modify Shelves\n\n
        1. Create a Shelf\n
        2. Delete a Shelf\n
        3. Modify a Shelf\n
        4. Main Menu
        MENU
    puts menu
        action = STDIN.gets.chomp.to_i
end

def menu_four_perform(action, active_user)
    case action
    when 1 
        create_shelf_macro(active_user)
    when 2
        print_shelf_list(active_user)
        shelf_choice = choose_shelf
        #show shelf list
        #ask which shelf
        #call delete_shelf
    when 3 
        shelf_options(active_user)
    when 4
        return to_menu = true
    end
end



def shelf_options(active_user) #main thing we run under main menu option 4
    print_shelf_list(active_user) # print list of all user's shelves
    shelf_choice = choose_shelf # get user to select a shelf to interact with
    to_menu = false
    until to_menu == true
        action = modify_shelf_menu #returns a user action
        modify_shelf(shelf_choice, action)
        # choose_shelf_menu_option(shelf_choice) # get user action choice and perform action
    end
end

def modify_shelf_menu #returns a menu action
    menu = <<-TXT 
        \n\nWhat would you like to do?\n\n
        1. View Shelf Contents \n
        2. Remove Book \n
        3. Add Book \n
        4. Rename Shelf \n
        5. Main Menu \n
    TXT
    #a stretch goal would be to add an option here to move a book to a different shelf
    puts menu
    action = gets.chomp.to_i
end

def print_shelf_list(active_user)
    active_user.shelves.each_with_index do |shelf, index|
        puts "#{index + 1}. #{shelf.name}"
    end
end

def choose_shelf #this method returns a shelf instance
    puts "Choose a shelf"
    user_input = STDIN.gets.chomp.to_i
    shelf_choice = active_user.shelves[user_input - 1]
end



def modify_shelf(shelf, action) #takes in a shelf instance
    case action #need to loop around this if statement to some extent
    when 1 
        view_shelf_contents(shelf) 
    when 2 
        remove_book(shelf)
        # (stretch to remove from all shelves at once)
    when 3
        add_book(shelf) #either adds a book to a shelf or does nothing and returns us to the modify contents menu
    when 4
        #rename shelf
    when 5 #return to main menu
        to_menu = true
    end
    to_menu
end

def view_shelf_contents(shelf)
    puts "You don't have any books on this shelf yet!\n\n" if shelf.books.empty?
    shelf.books.each_with_index do |book, index|
        puts "#{index + 1}. #{book.title} by #{book.author.name}"
    end 
end

def remove_book(shelf)
    puts "Which book should we remove? Please enter a number:"
    view_shelf_contents(shelf)
    book_index = gets.chomp.to_i - 1
    book = shelf.books[book_index] #grab that book instance off their shelf
    shelf.remove_book_from_shelf(book) #calling the shelf instance method called remove_book_from_shelf
end

def add_book(shelf)#takes a shelf instance, and calls on the shelf instance method, add_book
    book = Book.find_book #will return a book instance if the user was successful, or nil if they gave up
    shelf.add_book_to_shelf(book) if book
end
