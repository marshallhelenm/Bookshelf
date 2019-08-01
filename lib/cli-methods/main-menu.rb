#start the program from the point after login/signup
    #where user is being given a list of what they can do

def main_menu(active_user)
    to_menu = false
    until to_menu == true
        action = main_menu_list
        to_menu = main_menu_action(active_user, action)
        if action == 7
            break
        end
        if to_menu == false
            STDIN.gets.chomp
        end
    end
    quitter = true
end

def main_menu_list
    menu_text = <<-MENU
        \n
        1. View my Wishlist\n
        2. View my Read Books\n
        3. View Shelves and Books\n
        4. Modify Shelves\n
        5. Search Books\n
        6. My Stats (Under Construction)\n
        7. Exit
        MENU
    puts "\n\nWhat would you like to do?\n"
    puts menu_text
    action = STDIN.gets.chomp.to_i
end

#NEEDS WORK
def main_menu_action(active_user, action)
    case action
    when 1 #view wishlist
        wishlist = active_user.shelves.find do |shelf|
            shelf.name == "My Wishlist"
        end
        wishlist.view_shelf_contents
        puts "\n"
    when 2 #view read books list
        read = active_user.shelves.find do |shelf|
            shelf.name == "My Read Books"
        end
        read.view_shelf_contents
    when 3 #view shelves
        to_menu = menu_option_three(active_user)
    when 4 #modify shelves
        menu_option_four(active_user)
    when 5 #search books
        book = Book.find_book #returns book instance
        #need to prompt user for what to do with the book
        #do those things
        action = found_book_action_menu(book)
        found_book_action(book, action, active_user)
    when 6 #my stats
        #(stretch goal)
    when 7 #exits the loop in our bookshelfcli.rb file
        return to_menu = true     
    end
end
