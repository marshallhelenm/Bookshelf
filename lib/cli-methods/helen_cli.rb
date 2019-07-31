def log_in_sign_up
    puts "Welcome to Bookshelf!"
    puts "1. Log in"
    puts "2. Sign up"
    action = gets.chomp.to_i
    if action == 1
        active_user = log_in
    else
        active_user = sign_up
    end
    active_user
end

def log_in
    logged_in = false
    until logged_in
        "Please enter a username:"
        username = gets.chomp
        active_user = User.all.find do |user|
            user.name == username
        end #will provide either a user instance, or nil
        if active_user #if it's truthy, that is
            logged_in = true
            puts "Welcome #{username}!"
            return active_user
        else
            puts <<-TXT 
            Sorry, I couldn't find a user by that name!\n
            1. Try again\n
            2. Sign up\n
            3. Exit program\n
            TXT
            action = gets.chomp.to_i
            if action == 2
                active_user = create_account
                logged_in = true
            elsif action == 3
                puts "Thanks for using Bookshelf!"
                exit!
            end
        end
    end
    active_user
end

def sign_up
    active_user = nil
    "Please enter a username:"
        until active_user
            username = gets.chomp
            active_user = User.all.find do |user|
                user.name == username
            end #will return either a user instance or nil
            if active_user 
                "Oops! That username is taken! Please enter a different username:"
            else
                active_user = User.create(username)
                wishlist = Shelf.create("My Wishlist")
                read = Shelf.create("My Read Books")
                active_user.shelves << wishlist << read
                active_user.save
                "Welcome, #{username}!"
            end
        end
    active_user
end

########################################################################

def remove_book(shelf)
    puts "Which book should we remove? Please enter a number:"
    view_shelf_contents(shelf)
    book_index = gets.chomp.to_i - 1
    book = shelf.books[book_index] #grab that book instance off their shelf
    shelf.remove_book_from_shelf(book) #calling the shelf instance method called remove_book_from_shelf
end

def add_book(shelf)#takes a shelf instance, and calls on the shelf instance method, add_book
    book = Book.find_book #will return a book instance if the user was successful, or nil if they gave up
    shelf.add_book_to_shelf(book) if book
end

def rename_shelf(shelf) #takes a shelf instance

end

def modify_shelf_menu
    menu = <<-TXT What would you like to do?\n
        1. View Shelf Contents \n
        2. Remove Book \n
        3. Add Book \n
        4. Rename Shelf \n
        5. Main Menu \n
    TXT
    #a stretch goal would be to add an option here to move a book to a different shelf
    puts menu
    action = gets.chomp.to_i
end

#modify shelf contents:
def modify_shelf(shelf, action) #takes in a shelf instance
    
    to_menu == false
    until to_menu == true
        action = gets.chomp
        case action #need to loop around this if statement to some extent
        when 1 
            view_shelf_contents(shelf) 
        when 2 
           remove_book(shelf)
            # (stretch to remove from all shelves at once)
        when 3
            add_book(shelf) #either adds a book to a shelf or does nothing and returns us to the modify contents menu
        when 4
            #rename shelf
        when 5 #return to main menu
            to_menu = true
        end
        puts menu 
    end
end