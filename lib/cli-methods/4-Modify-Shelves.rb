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
        puts `clear`
        shelf_options(active_user)
    when 4
        return to_menu = true
    else
        unknown_command
    end
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


