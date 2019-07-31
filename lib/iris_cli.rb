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
        # user is directly connected to shelves (they belong to the user, so can just use user.shelves)
        # iterate through list of shelves and print with indices (plus 1)
        #split this section into a separate print shelves method
        user.shelves.each_with_index do |shelf, index|
            if shelf == user.shelves[-1]
                puts "#{index + 1}. #{shelf.name}"
                puts "#{index + 2}. Exit to Main Menu"
            else
                puts "#{index + 1}. #{shelf.name}"
            end
        end

        #get user choice
        user_input = gets.chomp.to_i
        #check user choice
        if user_input < user.shelves.length
            user.shelves.each_with_index do |shelf, index|
            if user_input == index
                puts "You have selected #{shelf.name}"
                puts "What would you like to do?"
                puts "1. View shelf contents"
                puts "2. Modify shelf"# (at this point we would be going to a different method) - specify (add/delete shelf)
                puts "3. Modify contents"# (different method) - specify (add/delete books)
                puts "4. Exit to main menu"
                new_user_input = gets.chomp.to_i
                case new_user_input
                when 1
                    #separate method
                    shelf.books.each_with_index do |book, index|
                        puts "#{index + 1}. #{book.title}"
                    end
                when 2
                    #separate method
                when 3
                    #separate method
                when 4
                    #code to run main menu
                end
            end
        else
            #code to run main menu (after welcome and signup/login screen)
        end
    end