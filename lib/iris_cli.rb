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

    def view_shelf(user_id)
        # find the user shelves using user id == self
        Shelfjoin.all.find_by(user.id == user.id)
        # iterate through list of shelves and print with indices (plus 1)
    end