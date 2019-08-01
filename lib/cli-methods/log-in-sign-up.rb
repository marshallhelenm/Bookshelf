#first thing that runs!
def log_in_sign_up
    puts "Welcome to Bookshelf!"
    puts "1. Log in"
    puts "2. Sign up"
    puts "3. Quit"
    action = STDIN.gets.chomp.to_i
    if action == 1
        active_user = log_in
    elsif action == 2
        active_user = sign_up
    else
        puts "\n\nThanks for using Bookshelf!"
        exit!
    end
    active_user
end

def log_in
    logged_in = false
    until logged_in
        puts "Please enter a username:"
        username = STDIN.gets.chomp
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
            action = STDIN.gets.chomp.to_i
            if action == 2
                active_user = sign_up
                logged_in = true
            elsif action == 3
                puts "\n\nThanks for using Bookshelf!"
                exit!
            end
        end
    end
    active_user
end

def sign_up
    active_user = nil
    puts "Please enter a username or 'quit' to quit:"
        until active_user
            username = STDIN.gets.chomp
            return if username.downcase.include?('quit')
            active_user = User.all.find do |user|
                user.name == username
            end #will return either a user instance or nil
            if active_user 
                puts "Oops! That username is taken! Please enter a different username:"
            else
                active_user = User.create(name: username)
                wishlist = Shelf.create(name: "My Wishlist")
                read = Shelf.create(name: "My Read Books")
                active_user.shelves << wishlist << read
                active_user.save
                "Welcome, #{username}!"
            end
        end
    active_user
end