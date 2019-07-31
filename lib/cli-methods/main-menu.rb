#start the program from the point after login/signup
    #where user is being given a list of what they can do
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
        puts "What would you like to do?"
        puts menu_text
        action = gets.chomp.to_i
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
            view_shelf_contents(read)
        when 3 #view all shelves
            print_shelf_list(active_user)
        when 4 #modify shelves
            shelf_options(active_user)
            # modify_shelf(shelf)
        when 5 #search books
            Book.find_book
        when 6 #search author
            #(stretch goal)
        when 7 #exits the loop in our bookshelfcli.rb file
            quitter = true
        end
    end
