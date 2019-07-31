# 1. View my Wishlist
#         Print contents of Wishlist shelf for this user with no description
#         tell the user to enter a number for more info
#             show full book info
#     2. View my Read Books 
#         see #1
#     3. View Shelf List
#         Pretty print a list of their shelf names
#         prompt them to select a shelf, or leave 
#         a. select a shelf
#             ask them what they want to do with it
#             i. view contents
#                 see #1
#             ii. modify shelf
#                 direct to #4
#             iii. modify contents


#View shelf List pseudocode - should these all be loops?

# when userinput == view shelf list option ->
    # find the user shelves using user id == self
    # iterate through list of shelves and print with indices (plus 1)
# now puts a message with numbered options for user actions
    # 1 - ? are equivalent to the printed list - selecting takes the user to the next step
    # last option is to exit to main menu
    # get user input
# If user inputs a number corresponding to a shelf index + 1 give them numbered options
    # 1. View shelf contents
    # 2. Modify shelf (at this point we would be going to a different method) - specify (add/delete shelf)
    # 3. Modify contents (different method) - specify (add/delete books)
    # 4. Exit to main menu
    # get user input


    #helper method
    def choose_shelf
        puts "Choose a shelf"
        user_input = gets.chomp.to_i
        shelf_choice = active_user.shelves[user_input - 1]
    end

    #helper method
    def shelf_menu(shelf_choice)
        menu = <<-MENU
            You have selected #{shelf_choice.name}\n
            What would you like to do?\n
            1. View shelf contents\n
            2. Modify shelf"# (at this point we would be going to a different method) - specify (add/delete shelf)\n
            3. Modify contents"# (different method) - specify (add/delete books)\n
            4. Exit to main menu
        MENU
        puts menu
    end

    #NEEDS WORK
    def choose_shelf_menu_option(shelf_choice)
        new_user_input = gets.chomp.to_i
        case new_user_input
        when 1 # view shelf contents
            view_shelf_contents(shelf_choice)
        when 2 # modify shelf
            #separate method modify shelf
        when 3 #modify contents
            #separate method modify contents
        when 4 #exit to main menu
            main_menu_list
        end
    end


    def view_shelves(active_user) #needs to be renamed - breaking up into smaller parts
        print_shelf_list(active_user) # print list of all user's shelves
        shelf_choice = choose_shelf # get user to select a shelf to interact with
        shelf_menu(shelf_choice) # print options for how user can interact with the shelf
        choose_shelf_menu_option(shelf_choice) # get user action choice and perform action
    end

    #helper method to print out a list of the user's shelves
    def print_shelf_list(active_user)
        # user is directly connected to shelves (they belong to the user, so can just use user.shelves)
        active_user.shelves.each_with_index do |shelf, index|
            if shelf == user.shelves[-1]
                puts "#{index + 1}. #{shelf.name}"
                puts "#{index + 2}. Exit to Main Menu"
            else
                puts "#{index + 1}. #{shelf.name}"
            end
        end
    end

    #helper method to print out contents of the shelf
    def view_shelf_contents(shelf)
        shelf.books.each_with_index do |book, index|
            puts "#{index + 1}. #{book.title} by #{book.author.name}"
        end
    end


    def main_menu_list
        #should start the program from the point after login/signup
        #where user is being given a list of what they can do
        menu_text = <<-MENU
            1. View my Wishlist\n
            2. View my Read Books\n
            3. View my Shelf List\n
            4. Modify Shelves\n
            5. Search Books\n
            6. Search Author\n
            7. Exit
            MENU
        puts "What would you like to do?"
        puts menu_text
        #now we need to get an input from the user
        user_input = gets.chomp.to_i
    end

    #NEEDS WORK
    def main_menu_action(active_user, user_input)
        case user_input
        when 1
            wishlist = active_user.shelves.find do |shelf|
                shelf.name == "My Wishlist"
            end
            view_shelf_contents(wishlist)
        when 2
            read = active_user.shelves.find do |shelf|
                shelf.name == "My Read Books"
            view_shelf_contents(read)
        when 3
            view_shelves(active_user)
        when 4
            #need to write the modify shelves stuff
        when 5
            #search books
            Book.find_book
        when 6
            #search author - need to write (stretch goal)
        when 7
            #exits the loop in our bookshelfcli.rb file
            quitter = true
        end
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

    #helper method if the user tries to create a shelf that is already in the database
    def shelf_already_exists(active_user)
        text = <<-TEXT
                Oops! That shelf already exists!\n
                What would you like to do?\n
                1. Select the existing shelf\n
                2. Try a new shelf name
        TEXT
        puts text
        user_input = gets.chomp.to_i
    end

    #take in user input after getting shelf exists error
    def action_for_shelf_exists(action)
        if action == 1
            #move to shelf instance methods
        else
            ask_user_for_new_shelf
        end
    end

    def ask_user_for_new_shelf
        puts "What would you like to name your new shelf?"
        new_shelf_name = gets.chomp
    end

    def create_new_shelf(new_shelf_name, active_user)
        shelf = Shelf.all.find {|shelf| shelf.name == new_shelf_name }
        if shelf
            shelf_already_exists(active_user)
        else
            new_shelf_description = gets.chomp
            my_new_shelf = Shelf.create(name: new_shelf_name, description: new_shelf_description, user_id: active_user.id)
            active_user.shelves << my_new_shelf
            active_user.save
        end
    end

    def add_books_to_new_shelf
        text = <<-TEXT
                    Would you like to add books to this shelf or move on?\n
                    1. Add books\n
                    2. Exit to Main Menu
                TEXT
        puts text
        user_input = gets.chomp.to_i
        if user_input == 1
            #run add books method
        else
            main_menu_list
        end
    end




    # def create_shelf(active_user)
    #     action = 0
    #     until action == 2
    #         puts "What would you like to name your new shelf?"
    #         new_shelf_name = gets.chomp
    #         #check to see if shelf name already exists - would find_or_create work better?
    #         #Shelf.all.find_or_create_by
    #         shelf = Shelf.all.find {|shelf| shelf.name == new_shelf_name }
    #         if shelf
    #             shelf_already_exists(active_user)
    #         else
    #             new_shelf_description = gets.chomp
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
    #             user_input = gets.chomp.to_i
    #             if user_input == 1
    #                 #run add books method
    #             else
    #                 main_menu_list
    #             end
    #         end
    #     end
    # end


