# I come in and load the program
#     Log in 
#         prompt user for username 
#         assign it to a variable so we can refer to them throughout the program
#     or create username (find user by username)
#         prompt for username
#         check to see if it's available - if not, prompt again
#         create instance + assign it to a variable
#         create wishlist & read books and associate those shelves with the user

def log_in_sign_up
    puts "Welcome to Bookshelf!
    1. Log in
    2. Sign up"
    action = gets.chomp.to_i
    if log in
        "Please enter a username:"
        username = gets.chomp
        user = User.all search for user by username
        if user is found
            "Welcome #{username}!"
        else
            "I couldn't find a user by that name.
            1. try again
            2. sign up"
            action = gets.chomp.to_i
        end
    else
        "Please enter a username:"
        until user is truthy (does that work?)
            username = gets.chomp
            user = User.all search to see if user exists already
            if user is nil or [] or whatever
                user = User.create(username)
                "Welcome, #{username}!"
            else
                "Oops! That username is taken! Please enter a different username:"
            end
        end
    end
end