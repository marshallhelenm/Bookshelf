active_user = log_in_sign_up #prompts the user to sign in or sign up, and returns a user instance
user_input = main_menu_list #list main menu options & get a choice from the user
main_menu_action(active_user, user_input) #perform the appropriate action


#they select view shelves this happens:
print_shelf_list(active_user)
shelf_choice = choose_shelf #a method that takes user input


