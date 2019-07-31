#start the program from the point after login/signup
    #where user is being given a list of what they can do

def main_menu(active_user)
    to_menu = false
    until to_menu == true
        action = main_menu_list
        to_menu = main_menu_action(active_user, action)
    end
    quitter = true
end

def main_menu_list
    menu_text = <<-MENU
        1. View my Wishlist\n
        2. View my Read Books\n
        3. View my Shelf List\n
        4. Modify Shelves\n
        5. Search Books\n
        6. Search Author\n
        7. Exit
        MENU
    puts "What would you like to do?\n\n"
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
        view_shelf_contents(wishlist)
    when 2 #view read books list
        read = active_user.shelves.find do |shelf|
            shelf.name == "My Read Books"
        end
        view_shelf_contents(read)
    when 3 #view all shelves
        print_shelf_list(active_user)
    when 4 #modify shelves
        menu_option_four(active_user)
    when 5 #search books
        Book.find_book #returns book instance
        #need to prompt user for what to do with the book
        #do those things
    when 6 #search author
        #(stretch goal)
    when 7 #exits the loop in our bookshelfcli.rb file
        to_menu = true     
    end
end
