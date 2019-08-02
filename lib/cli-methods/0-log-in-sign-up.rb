#first thing that runs!
def log_in_sign_up
    welcome
    logged_in = false
    until logged_in == true
        puts <<-LIST
        1. Log in
        2. Sign up
        3. Quit
        LIST
        action = STDIN.gets.chomp.to_i
        puts `clear`
        if action == 1
            active_user = log_in
            logged_in = true
        elsif action == 2
            active_user = sign_up
            logged_in = true
        elsif action == 3
            goodbye
            exit!
        else 
            unknown_command
        end
    end
    active_user
end

def log_in
    logged_in = false
    until logged_in
        puts "\nPlease enter a username:\n"
        username = STDIN.gets.chomp
        active_user = User.all.find do |user|
            user.name == username
        end #will provide either a user instance, or nil
        if active_user #if it's truthy, that is
            logged_in = true
            puts `clear`
            puts "\nWelcome #{username}!"
            return active_user
        else
            puts <<-TXT 
    \nSorry, I couldn't find a user by that name!\n
    1. Try again
    2. Sign up
    3. Exit program
    TXT
            action = STDIN.gets.chomp.to_i
            if action == 2
                active_user = sign_up
                logged_in = true
            elsif action == 3
                goodbye
                exit!
            end
        end
    end
    active_user
end

def sign_up
    active_user = nil
    puts "\nPlease enter a username or 'quit' to quit:\n"
        until active_user
            username = STDIN.gets.chomp
            if username.downcase.include?('quit')
                goodbye
                exit! #exit method if they enter quit
            end

            active_user = User.all.find do |user|
                user.name == username
            end #will return either a user instance or nil

            if active_user 
                puts "Oops! That username is taken! Please enter a different username:\n"
                active_user = nil
            else
                active_user = User.create(name: username)
                wishlist = Shelf.create(name: "My Wishlist")
                read = Shelf.create(name: "My Read Books")
                active_user.shelves << wishlist << read
                active_user.save
                puts "\n\nWelcome, #{username}! Your account has been created.\n"
                STDIN.gets.chomp
            end
        end
    active_user
end

def welcome
    puts <<-ASC
       .--.                   .---.
   .---|__|           .-.     |~~~|
.--|===|--|_          |_|     |~~~|--.
|  |===|  |'\\     .---!~|  .--|   |--|
|%%|   |  |.'\\    |===| |--|%%|   |  |
|%%|   |  |\\.'\\   |   | |__|  |   |  |
|  |   |  | \\  \\  |===| |==|  |   |  |
|  |   |__|  \\.'\\ |   |_|__|  |~~~|__|
|  |===|--|   \\.'\\|===|~|--|%%|~~~|--|
^--^---'--^    `-'`---^-^--^--^---'--'
\n      Welcome to Bookshelf!\n
    ASC
end

def goodbye
puts <<-BYE
                ______ ______
              _/      Y      \\\_
             // ~~ ~~ | ~~ ~  \\\\
            // ~ ~ ~~ | ~~~ ~~ \\\\      
           //________.|.________\\\\     
          `----------`-'----------'
        Thank you for using Bookshelf!

BYE
end