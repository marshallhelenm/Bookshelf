require_all 'lib/'

class BookshelfCLI
    def self.run 
        active_user = log_in_sign_up #prompts the user to sign in or sign up, and returns a user instance
        quitter = false
        until quitter == true
            quitter = main_menu(active_user) #perform the appropriate action
        end
        puts goodbye
    end
end

