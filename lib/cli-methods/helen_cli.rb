# I come in and load the program
#     Log in 
#         prompt user for username 
#         assign it to a variable so we can refer to them throughout the program
#     or create username (find user by username)
#         prompt for username
#         check to see if it's available - if not, prompt again
#         create instance + assign it to a variable
#         create wishlist & read books and associate those shelves with the user


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
            2. Create account\n
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


def create_account
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

def log_in_sign_up
    puts "Welcome to Bookshelf!"
    puts "1. Log in"
    puts "2. Sign up"
    action = gets.chomp.to_i
    if action == 1
        active_user = log_in
    else
        active_user = create_account
    end
    active_user
end

########################################################################

def remove_book(shelf)
    puts "Which book should we remove? Please enter a number:"
    view_shelf_contents(shelf)
    book_index = gets.chomp.to_i - 1
    book = shelf.books[book_index]
    shelf.remove_book(book) #calling the shelf instance method called remove_book
end

def add_book(shelf)
    #takes a shelf instance, and calls on the shelf instance method, add_book
    book = Book.find_book #will return a book instance if the user was successful, or nil if they gave up
    shelf.add_book(book) if book
end

#modify shelf contents:
def modify_contents(shelf)
    menu = <<-TXT What would you like to do?\n
        1. View Shelf Contents \n
        2. Remove Book \n
        3. Add Book \n
        4. Main Menu \n
    TXT
    #a stretch goal would be to add an option here to move a book to a different shelf
    puts menu
    until #something - probably when action = main menu
        action = gets.chomp
        case action #need to loop around this if statement to some extent
        when 1 
            view_shelf_contents(shelf) 
        when 2 
           remove_book(shelf)
            # (stretch to remove from all shelves at once)
        when 3
            add_book(shelf) #either adds a book to a shelf or does nothing and returns us to the modify contents menu
        when 4 #return to main menu
            return quitter = false
        end
        puts menu 
    end
end