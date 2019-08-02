def unknown_command
    puts "\nI don't recognize that command, please try again.\n\n"
end


def print_shelf_list(active_user)
    puts ""
    active_user.shelves.each_with_index do |shelf, index|
        puts <<-TXT
    #{index + 1}. #{shelf.name}
    TXT
    end
end

def choose_shelf(active_user) #this method returns a shelf instance
    puts "\nChoose a shelf"
    print_shelf_list(active_user)
    action = STDIN.gets.chomp.to_i
    unknown_command if action > active_user.shelves.length + 1
    shelf_choice = active_user.shelves[action - 1]
end


def update_user_variable(active_user)
    username = active_user.name
    active_user = User.all.find do |user|
        user.name == username
    end
    active_user
end