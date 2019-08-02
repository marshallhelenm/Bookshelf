
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
            STDIN.gets.chomp
            puts `clear`
        end
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

def ask_user_for_new_shelf
    puts `clear`
    puts "What would you like to name your new shelf?"
    new_shelf_name = STDIN.gets.chomp
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
