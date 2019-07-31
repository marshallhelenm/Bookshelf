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
        until user
            username = gets.chomp
            active_user = User.all.find do |user|
                user.name == username
            end #will return either a user instance or nil
            if !active_user 
                active_user = User.create(username)
                wishlist = Shelf.create("My Wishlist")
                read = Shelf.create("My Read Books")
                active_user.shelves << wishlist << read
                "Welcome, #{username}!"
            else
                "Oops! That username is taken! Please enter a different username:"
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