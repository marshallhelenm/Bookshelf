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
        4. Menu
        MENU
    puts menu
        action = STDIN.gets.chomp.to_i
end

def menu_four_perform(action, active_user)
    case action
    when 1 
        create_shelf_macro(active_user)
    when 2
        shelf_choice = choose_shelf(active_user)
        delete_shelf(shelf_choice, active_user)
        puts "Your shelves:\n"
        print_shelf_list(active_user)
    when 3 
        shelf_options(active_user)
    when 4
        return to_menu = true
    end
end



def shelf_options(active_user) #main thing we run under main menu option 4
    print_shelf_list(active_user) # print list of all user's shelves
    to_menu = false
    until to_menu == true
        action = modify_shelf_menu #returns a user action
        to_menu = modify_shelf(action, active_user)
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
    action = STDIN.gets.chomp.to_i
end

def print_shelf_list(active_user)
    active_user.shelves.each_with_index do |shelf, index|
        puts "#{index + 1}. #{shelf.name}"
    end
end

def choose_shelf(active_user) #this method returns a shelf instance
    puts "Choose a shelf"
    print_shelf_list(active_user)
    user_input = STDIN.gets.chomp.to_i
    shelf_choice = active_user.shelves[user_input - 1]
end



def modify_shelf(action, active_user) #takes in a shelf instance
    case action #need to loop around this if statement to some extent
    when 1  #view shelf contents
        shelf_choice = choose_shelf(active_user) # get user to select a shelf to interact with
        view_shelf_contents(shelf_choice) 
    when 2 #remove a book from a shelf
        shelf_choice = choose_shelf(active_user) # get user to select a shelf to interact with
        remove_book(shelf_choice)
        # (stretch to remove from all shelves at once)
    when 3 #add a book to a shelf 
        shelf_choice = choose_shelf(active_user) # get user to select a shelf to interact with
        add_book(shelf_choice) #either adds a book to a shelf or does nothing and returns us to the modify contents menu
    when 4 #rename shelf
        shelf_choice = choose_shelf(active_user)
        rename_shelf(shelf_choice) # get user to select a shelf to interact with
        #rename shelf(shelf_choice)
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
    book_index = STDIN.gets.chomp.to_i - 1
    book = shelf.books[book_index] #grab that book instance off their shelf
    shelf.remove_book_from_shelf(book) #calling the shelf instance method called remove_book_from_shelf
end

def add_book(shelf)#takes a shelf instance, and calls on the shelf instance method, add_book
    book = Book.find_book #will return a book instance if the user was successful, or nil if they gave up
    shelf.add_book_to_shelf(book) if book
end

def rename_shelf(shelf) #takes a shelf instance
    puts "Please enter a new name for your #{shelf.name} shelf:\n"
    new_name = STDIN.gets.chomp
    puts "Your #{shelf.name} shelf will be renamed #{new_name}. Proceed? (y/n)\n"
    action = STDIN.gets.chomp
    if action == "y"
        shelf.rename(new_name)
        puts "Your shelf is now named #{shelf.name}."
    end
end