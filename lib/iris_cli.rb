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

    def view_shelf(user)
        # iterate through list of shelves and print with indices
        print_shelf_list(user)

        #get user choice
        user_input = gets.chomp.to_i

        if user_input == shelf.length + 1
            # exit to main menu
        else
            shelf_choice = user.shelves[user_input - 1] 
            puts "You have selected #{shelf_choice.name}"
            puts "What would you like to do?"
            puts "1. View shelf contents"
            puts "2. Modify shelf"# (at this point we would be going to a different method) - specify (add/delete shelf)
            puts "3. Modify contents"# (different method) - specify (add/delete books)
            puts "4. Exit to main menu"
            new_user_input = gets.chomp.to_i
            case new_user_input
            when 1
                #separate method
                view_shelf_contents(shelf_choice)
            when 2
                #separate method modify shelf
            when 3
                #separate method modify contents
            when 4
                #code to run main menu
            end
        else
            #code to run main menu (after welcome and signup/login screen)
        end
    end

    #helper method to print out a list of the user's shelves
    def print_shelf_list(user)
        # user is directly connected to shelves (they belong to the user, so can just use user.shelves)
        user.shelves.each_with_index do |shelf, index|
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


    #attempt at pseudocode to exit to main menu
    def return_to_main_menu #rename just main menu
        #should restart the program from the point after login/signup
        #where user is being given a list of what they can do
        #1. View my Wishlist
        # 2. View my Read Books 
        # 3. View Shelf List 
        #     a. select a shelf
        #         i. view contents
        #         ii. modify shelf
        #         iii. modify contents
        # 4. Modify shelves
        #     a. create Shelf
        #     b. delete shelf 
        #         i. which shelf?
        #     c. rename shelf
        #         i. which shelf?
        #     d. modify contents
        #         i. which shelf?
        # 5. Search books 
        #     a. add to a shelf
        #     b. search again
        # 6. Search author (stretch)
        # 7. Exit
        menu_text = <<-MENU
            1. View my Wishlist
            2. View my Read Books
            3. View my Shelf List
            4. Modify Shelves
            5. Search Books
            6. Search Author
            7. Exit
            MENU
        puts menu_text
        #now we need to get an input from the user
        user_input = gets.chomp.to_i
        while user_input != 7
        case user_input 
        when 1
            view_shelf_contents(#wishlist?)
        when 2
            view_shelf_contents(#read_books?)
        when 3
            view_shelf(#need user instance at this point)
        when 4
        when 5
        when 6
        end
            
    end