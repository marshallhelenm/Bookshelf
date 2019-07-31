active_user = log_in_sign_up #prompts the user to sign in or sign up, and returns a user instance
quitter = false
until quitter == true
    user_input = main_menu_list #list main menu options & get a choice from the user
    main_menu_action(active_user, user_input) #perform the appropriate action
end
puts "Thanks for using Bookshelf!"


