    #helper method if the user tries to create a shelf that is already in the database
    def shelf_already_exists(active_user)
        text = <<-TEXT
                Oops! That shelf already exists!\n
                What would you like to do?\n
                1. Select the existing shelf\n
                2. Try a new shelf name
        TEXT
        puts text
        action = STDIN.gets.chomp.to_i
    end

    #take in user input after getting shelf exists error
    def action_for_shelf_exists(action)
        if action == 1
            shelf_menu(shelf_choice) # print options for how user can interact with the shelf
            choose_shelf_menu_option(shelf_choice) # get user action choice and perform actio
        else
            ask_user_for_new_shelf
        end
    end


    def create_shelf_macro(active_user)
        shelf_name = ask_user_for_new_shelf
        create_new_shelf(shelf_name, active_user)
    end

    def ask_user_for_new_shelf
        puts "What would you like to name your new shelf?"
        new_shelf_name = STDIN.gets.chomp
    end

    def create_new_shelf(new_shelf_name, active_user)
        shelf = Shelf.all.find {|shelf| shelf.name == new_shelf_name }
        if shelf
            action = shelf_already_exists(active_user)
            action_for_shelf_exists(action)
        else
            puts "Please enter a description for your new bookshelf #{new_shelf_name} or press 'enter' to skip."
            new_shelf_description = STDIN.gets.chomp
            my_new_shelf = Shelf.create(name: new_shelf_name, description: new_shelf_description, user_id: active_user.id)
            active_user.shelves << my_new_shelf
            active_user.save
        end
        puts "\n\nYour new shelf #{my_new_shelf.name} has been successfully created!"
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
            shelf.delete
        end
        active_user.shelves.delete(shelf)
    end

























    # 4. Modify shelves
    #     a. create Shelf
    #     b. delete shelf 
    #         i. which shelf?
    #     c. rename shelf
    #         i. which shelf?
    #     d. modify contents
    #         i. which shelf?

    # create Shelf
    #         prompt for a shelf name (if our holder variable is empty)
    #         create shelf instance, and associate it to the user
    #         ask if they want to add books. 
    #             if no, back to start
    #             if yes, modify contents
    #     b. delete shelf 
    #         prompt for shelf name
    #         check if it exists
    #         ask them if they are sure they want to delete the shelf (show name)
    #         delete shelf instance and all associated shelfjoin instances
    #     c. rename shelf
    #         i. which shelf?
    #         reassign name
    #         show new name, ask if that was right
    #         if yes, save to database,
    #         if not: try again?, quit


    # def create_shelf(active_user)
    #     action = 0
    #     until action == 2
    #         puts "What would you like to name your new shelf?"
    #         new_shelf_name = STDIN.gets.chomp
    #         #check to see if shelf name already exists - would find_or_create work better?
    #         #Shelf.all.find_or_create_by
    #         shelf = Shelf.all.find {|shelf| shelf.name == new_shelf_name }
    #         if shelf
    #             shelf_already_exists(active_user)
    #         else
    #             new_shelf_description = STDIN.gets.chomp
    #             my_new_shelf = Shelf.create(name: new_shelf_name, description: new_shelf_description, user_id: active_user.id)
    #             active_user.shelves << my_new_shelf
    #             active_user.save
    #             #ask if they want to add books
    #             text = <<-TEXT
    #                 Would you like to add books to this shelf or move on?\n
    #                 1. Add books\n
    #                 2. Exit to Main Menu
    #             TEXT
    #             puts text
    #             user_input = STDIN.gets.chomp.to_i
    #             if user_input == 1
    #                 #run add books method
    #             else
    #                 main_menu_list
    #             end
    #         end
    #     end
    # end


