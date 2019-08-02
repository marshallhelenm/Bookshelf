def menu_option_three(active_user)
    action = 0
    menu = active_user.shelves.length + 1
    until action == menu
        puts "Enter a shelf number to view its contents:"
        print_shelf_list(active_user)
        puts <<-TXT
    #{menu}. Return to Menu
        TXT
        action = STDIN.gets.chomp.to_i
        if action == menu
            return #to_menu = true
        elsif action <= active_user.shelves.length
            shelf_choice = active_user.shelves[action - 1]
            shelf_choice.view_shelf_contents #print books
            STDIN.gets.chomp
        else
            unknown_command
        end
        
    end
end