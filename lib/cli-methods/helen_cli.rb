def unknown_command
    puts "\nI don't recognize that command, please try again.\n\n"
end




def update_user_variable(active_user)
    username = active_user.name
    active_user = User.all.find do |user|
        user.name == username
    end
    active_user
end