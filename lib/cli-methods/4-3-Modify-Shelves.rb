### 4.3. Modify Shelves ###

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

def modify_shelf(action, active_user) #takes in a shelf instance
    case action #need to loop around this if statement to some extent
    when 1  #view shelf contents
        shelf_choice = choose_shelf(active_user) # get user to select a shelf to interact with
        puts `clear`
        shelf_choice.view_shelf_contents 
        to_menu = false
    when 2 #remove a book from a shelf
        puts `clear`
        shelf_choice = choose_shelf(active_user) # get user to select a shelf to interact with
        remove_book(shelf_choice, active_user)
        STDIN.gets.chomp
        puts `clear`
        # (stretch to remove from all shelves at once)
    when 3 #add a book to a shelf 
        puts `clear`
        shelf_choice = choose_shelf(active_user) # get user to select a shelf to interact with
        add_book(shelf_choice) #either adds a book to a shelf or does nothing and returns us to the modify contents menu
        STDIN.gets.chomp
        puts `clear`
    when 4 #rename shelf
        puts `clear`
        shelf_choice = choose_shelf(active_user)
        rename_shelf(shelf_choice) # get user to select a shelf to interact with
        STDIN.gets.chomp
        puts `clear`
        #rename shelf(shelf_choice)
    when 5 #edit shelf description
        puts `clear`
        shelf_choice = choose_shelf(active_user)
        edit_shelf_description(shelf_choice)
        STDIN.gets.chomp
        puts `clear`
    when 6 #return to main menu
        puts `clear`
        to_menu = true
    else
        unknown_command
    end
    
end