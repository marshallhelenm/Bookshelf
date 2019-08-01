#menu options for stats
def stats_menu_options(active_user)
    menu = <<-MENU
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
    MENU
    action = STDIN.gets.chomp.to_i
end


#actions for menu options
def stats_menu_action(action, active_user)
    case action
    when 1
        most_recently_read(active_user)
    when 4
        count_my_books(active_user)
    when 5
        shelf_choice = choose_shelf(active_user)
        my_read_count(shelf_choice)
    when 6
        my_average_shelf_count(active_user)
    when 7
        my_authors(active_user)
    when 8
        shelf_choice = choose_shelf(active_user)
    when 9
        list_all_my_books(active_user)
    when 10
    else
    end
end






#without adding a status column for books 
#getting currently reading doesn't make sense
def most_recently_read(active_user)
    puts "\nYour most recently read book is: #{active_user.books.last.title}."
end

def most_popular_book
    # Book.all.max_by do |book|
        
    # end
end

def my_read_count(shelf_choice)
    puts "\nYou have #{shelf_choice.length} books on your #{shelf_choice.name} shelf."
end

def count_my_books(active_user)
    puts "\nYou have a total of #{active_user.books.length} books in the Bookshelf™ database."
end

def my_average_shelf_count(active_user)
    average = active_user.shelves.collect do |shelf|
        shelf.books.length
    end.sum / (active_user.shelves.length * 1.0)
    puts "\nYou have an average of #{average} books per shelf in the Bookshelf™ database."
end

def my_authors(active_user)
    author_names = active_user.books.collect do |book|
        book.author.name
    end
    author_names.each_with_index do |author, index|
        puts "#{index +1 }. #{author}"
    end
end

def authors_on_shelf(shelf_choice)
    author_names = shelf_choice.collect do |shelf|
        shelf.book.author.name
    end
    author_names.each_with_index do |author, index|
        puts "#{index + 1}. #{author}"
    end
end

def list_all_my_books(active_user)
    active_user.books.each_with_index do|book, index|
        puts "#{index +1}. #{book.title}"
    end
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