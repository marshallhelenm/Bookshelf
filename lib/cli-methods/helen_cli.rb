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



def rename_shelf(shelf) #takes a shelf instance

end