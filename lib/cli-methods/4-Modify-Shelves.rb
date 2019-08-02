#Main Menu Option 4

def menu_option_four(active_user)
    to_menu = false
    until to_menu == true
        action = menu_four #(shows menu and gets action)
        break if action == 4
        to_menu = menu_four_perform(action, active_user)
    end 
end

def menu_four
    menu = <<-MENU
    Modify Shelves\n
    1. Create a Shelf
    2. Delete a Shelf
    3. Modify a Shelf
    4. Menu
    MENU
    puts menu
        action = STDIN.gets.chomp.to_i
end

def menu_four_perform(action, active_user)
    case action
    when 1 
        create_new_shelf(active_user)
    when 2
        shelf_choice = choose_shelf(active_user)
        delete_shelf(shelf_choice, active_user)
        puts "Your shelves:\n"
        print_shelf_list(active_user)
    when 3 #modify a shelf
        shelf_options(active_user)
    when 4
        return to_menu = true
    else
        unknown_command
    end
end



def shelf_options(active_user) #main thing we run under main menu option 4
    puts "\nYour shelves:"
    print_shelf_list(active_user) # print list of all user's shelves
    to_menu = false
    until to_menu == true
        action = modify_shelf_menu #returns a user action
        to_menu = modify_shelf(action, active_user)
    end
end

def modify_shelf_menu #returns a menu action
    menu = <<-TXT 
    \n\nWhat would you like to do?\n
    1. View Shelf Contents 
    2. Remove Book 
    3. Add Book 
    4. Rename Shelf 
    5. Edit Shelf Description
    6. Return \n
    TXT
    #a stretch goal would be to add an option here to move a book to a different shelf
    puts menu
    action = STDIN.gets.chomp.to_i
end

def print_shelf_list(active_user)
    puts ""
    active_user.shelves.each_with_index do |shelf, index|
        puts <<-TXT
    #{index + 1}. #{shelf.name}
    TXT
    end
end

def choose_shelf(active_user) #this method returns a shelf instance
    puts "\nChoose a shelf"
    print_shelf_list(active_user)
    action = STDIN.gets.chomp.to_i
    unknown_command if action > active_user.shelves.length + 1
    shelf_choice = active_user.shelves[action - 1]
end



def modify_shelf(action, active_user) #takes in a shelf instance
    case action #need to loop around this if statement to some extent
    when 1  #view shelf contents
        shelf_choice = choose_shelf(active_user) # get user to select a shelf to interact with
        puts `clear`
        shelf_choice.view_shelf_contents 
        to_menu = false
    when 2 #remove a book from a shelf
        shelf_choice = choose_shelf(active_user) # get user to select a shelf to interact with
        remove_book(shelf_choice, active_user)
        # (stretch to remove from all shelves at once)
    when 3 #add a book to a shelf 
        shelf_choice = choose_shelf(active_user) # get user to select a shelf to interact with
        add_book(shelf_choice) #either adds a book to a shelf or does nothing and returns us to the modify contents menu
    when 4 #rename shelf
        shelf_choice = choose_shelf(active_user)
        rename_shelf(shelf_choice) # get user to select a shelf to interact with
        #rename shelf(shelf_choice)
    when 5 #edit shelf description
        shelf_choice = choose_shelf(active_user)
        edit_shelf_description(shelf_choice)
    when 6 #return to main menu
        to_menu = true
    else
        unknown_command
    end
    
end

def remove_book(shelf, active_user)
    if shelf.books.empty?
        puts "\nThis shelf is empty!"
    else
        puts `clear`
        puts "Which book should we remove? Please enter a number:"
        shelf.view_shelf_contents
        book_index = STDIN.gets.chomp.to_i - 1
        book = shelf.books[book_index] #grab that book instance off their shelf
        shelf.remove_book_from_shelf(book) #calling the shelf instance method called remove_book_from_shelf
        active_user = update_user_variable(active_user)
        puts "\nYou have successfully removed #{book.title} from #{shelf.name}."
        puts "\nShelf contents: "
        shelf.view_shelf_contents
    end
    active_user
end

def add_book(shelf)#takes a shelf instance, and calls on the shelf instance method, add_book
    book = Book.find_book #will return a book instance if the user was successful, or nil if they gave up
    shelf.add_book_to_shelf(book) if book
    STDIN.gets.chomp
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

def edit_shelf_description(shelf) #takes a shelf instance
    puts "Here is your current description:\n"
    puts shelf.description
    puts "\nPlease enter a new description for your #{shelf.name} shelf:\n"
    new_description = STDIN.gets.chomp
    puts "Here is your new description:\n #{new_description}\n Proceed? (y/n)\n"
    action = STDIN.gets.chomp
    if action == "y"
        shelf.edit_description(new_description)
        puts "Description has been updated!"
    end
end

#helper method if the user tries to create a shelf that is already in the database
def shelf_already_exists(active_user, shelf)
    text = <<-TEXT
\nOops! That shelf already exists!\n
What would you like to do?\n
    1. Modify shelf
    2. Try a new shelf name\n
        TEXT
    puts text
    action = 0
    until action == 1 || action == 2
        action = STDIN.gets.chomp.to_i
        if action == 1
            modification = modify_shelf_menu # print options for how user can interact with the shelf
            modify_shelf(modification, active_user)
            return done = true
        end
    end
end

    def ask_user_for_new_shelf
        puts `clear`
        puts "What would you like to name your new shelf?"
        new_shelf_name = STDIN.gets.chomp
    end

    def create_new_shelf(active_user)
        done = false
        until done == true
            new_shelf_name = ask_user_for_new_shelf
            shelf = Shelf.all.find {|shelf| shelf.name == new_shelf_name && shelf.user.name == active_user.name}
            if shelf
                done = shelf_already_exists(active_user, shelf)
            else
                puts "\nPlease enter a description for your new bookshelf '#{new_shelf_name}' or press 'enter' to skip."
                new_shelf_description = STDIN.gets.chomp
                my_new_shelf = Shelf.create(name: new_shelf_name, description: new_shelf_description, user_id: active_user.id)
                active_user.shelves << my_new_shelf
                active_user.save
                puts "\n\nYour new shelf #{my_new_shelf.name} has been successfully created!"
                done = true
            end
        end
    end

    def add_books_to_new_shelf
        text = <<-TEXT
                    Would you like to add books to this shelf or move on?\n
                    1. Add books\n
                    2. Exit to Main Menu
                TEXT
        puts text
        user_input = STDIN.gets.chomp.to_i
        if user_input == 1
            #run add books method
        else
            main_menu_list
        end
    end


    def delete_shelf(shelf, active_user)
        puts "Are you sure you want to delete your shelf: #{shelf.name}? (y/n)"
        action = STDIN.gets.chomp
        if action == 'y'
            active_user.shelves.delete(shelf)
            Shelf.all.delete(shelf)
        end
        
    end

