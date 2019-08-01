#menu options for stats
def stats_menu_options
    menu = <<-TEXT
    STATS MENU

    What would you like to do?

    1. View most recently read book
    2. View most popular book in Bookshelf database
    3. View most popular author in Bookshelf database
    4. Count my total books
    5. Count books on a shelf
    6. My average number of books per shelf
    7. List the authors on all of my shelves
    8. List the authors on one of my shelves
    9. List all of my books!
    10. Exit to Menu
    TEXT
    puts menu
    action = STDIN.gets.chomp.to_i
end


#actions for menu options
def stats_menu_action(action, active_user)
    case action
    when 1 #last book on the read books shelf
        most_recently_read(active_user)
    when 4 # count all of this user's books
        count_my_books(active_user)
    when 5 # Count books on a shelf
        shelf_choice = choose_shelf(active_user)
        my_read_count(shelf_choice)
    when 6 #get average number of books / shelf for a user
        my_average_shelf_count(active_user)
    when 7 # all the authors in the user's shelves
        my_authors(active_user)
    when 8 #
        shelf_choice = choose_shelf(active_user)
    when 9
        list_all_my_books(active_user)
    else
        unknown_command
    end
end


def menu_option_six(active_user)
    action = 0
    until action == 10
        action = stats_menu_options
        stats_menu_action(action, active_user)
    end
end



#without adding a status column for books 
#getting currently reading doesn't make sense
def most_recently_read(active_user)
    read_shelf = active_user.shelves.find do |shelf|
        shelf.name == "My Read Books"
    end
    if read_shelf.books.empty?
        puts "\nYou haven't read any books yet!\n"
    else
        puts "\nYour most recently read book is: #{read_shelf.books.last.title}."
    end
    puts
end

def most_popular_book
    # Book.all.max_by do |book|
        
    # end
end

def my_read_count(shelf_choice)
    if shelf_choice.books.empty?
        puts "\nYou don't have any books on this shelf yet!\n"
    else
        puts "\nYou have #{shelf_choice.books.length} books on your #{shelf_choice.name} shelf.\n"
    end
end

def count_my_books(active_user)
    if active_user.books.empty?
        puts "\nYou have not yet saved any books in the Bookshelf™ database."
    else
        puts "\nYou have a total of #{active_user.books.uniq.length} books saved in the Bookshelf™ database.\n"
    end
end

def my_average_shelf_count(active_user)
    if active_user.books.empty?
        puts "\nYou have not yet saved any books in the Bookshelf™ database.\n"
    else
        average = active_user.shelves.collect do |shelf|
            shelf.books.length
        end.sum / (active_user.shelves.length * 1.0)
        puts "\nYou have an average of #{average} books per shelf in the Bookshelf™ database.\n"
    end
end

def my_authors(active_user)  # should this also list the shelf name each author is on?
    if active_user.books.empty?
        puts "\nYou have not yet saved any books in the Bookshelf™ database.\n\n"
    else
        author_names = active_user.books.collect do |book|
            book.author.name
        end
        author_names.each_with_index do |author, index|
            puts "  #{index +1 }. #{author}"
        end
    end
    puts
end

def authors_on_shelf(shelf_choice)
    if shelf_choice.books.empty?
        puts "\nYou do not have any books on this bookshelf yet!\n"
    else
        author_names = shelf_choice.collect do |shelf|
            shelf.book.author.name
        end
        author_names.each_with_index do |author, index|
            puts "  #{index + 1}. #{author}"
        end
    end
    puts
end

def list_all_my_books(active_user)
    if active_user.books.empty?
        puts "\nYou do not have any books on this bookshelf yet!\n"
    else
        active_user.books.each_with_index do|book, index|
            puts "  #{index +1}. #{book.title}"
        end
    end
    puts
end


# Most popular book -- from all users?
# most popular author

#from Author class
#number of users that have this author on their shelves

#from shelf class
#how many books on a shelf
#list authors on a shelf

#from user class
#average num of books on user shelves
#list all books from all shelves for this user (count as well)
#count books read (count read booklist) / count books on any shelf
#authors on all of a user's shelves