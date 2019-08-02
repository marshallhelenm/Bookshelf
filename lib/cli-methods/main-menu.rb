#start the program from the point after login/signup
    #where user is being given a list of what they can do

def main_menu(active_user)
    thing = false
    until thing == "log out" || thing == "quit"
        action = main_menu_list
        main_menu_action(active_user, action)
        if action == 8
            goodbye
            exit!
        elsif action == 7
            thing = "log out"
        elsif thing == false
            STDIN.gets.chomp
        end
    end
    thing
end
 
def main_menu_list
    puts `clear`
    menu_text = <<-MENU
    \n
    MAIN MENU
\nWhat would you like to do?\n
    1. View my Wishlist
    2. View my Read Books
    3. View Shelves and Books
    4. Modify Shelves
    5. Search Books
    6. My Stats (Under Construction)
    7. Log Out
    8. Exit
    MENU
    puts menu_text
    action = STDIN.gets.chomp.to_i
end

#NEEDS WORK
def main_menu_action(active_user, action)
    case action
    when 1 #view wishlist
        puts `clear`
        wishlist = active_user.shelves.find do |shelf|
            shelf.name == "My Wishlist"
        end
        wishlist.view_shelf_contents
        puts "\n"
        STDIN.gets.chomp
    when 2 #view read books list
        puts `clear`
        read = active_user.shelves.find do |shelf|
            shelf.name == "My Read Books"
        end
        read.view_shelf_contents
    when 3 #view shelves
        puts `clear`
        to_menu = menu_option_three(active_user)
    when 4 #modify shelves
        puts `clear`
        menu_option_four(active_user)
    when 5 #search books
        puts `clear`
        book = Book.find_book #returns book instance
        return if !book
        book.display_db_book_info
        action = found_book_action_menu(book)
        found_book_action(book, action, active_user)
    when 6 #my stats
        puts `clear`
        menu_option_six(active_user)
    when 7 #log out
        return thing = "log out"
    when 8  
        return thing = "quit"
    else
        unknown_command   
    end
end
