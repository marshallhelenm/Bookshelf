#menu options for stats
def stats_menu_options(active_user)
    menu = <<-MENU
    1. View most recently read book
    2. View most popular book in Bookshelf database
    3. View most popular author in Bookshelf database
    4. Count my total books
    5. Count books on a shelf
    6. My average shelf book count
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
    when 2
        #most_popular_book
    when 3

end






#without adding a status column for books 
#getting currently reading doesn't make sense
def most_recently_read(active_user)
    active_user.books.last
end

def most_popular_book
    # Book.all.max_by do |book|
        
    # end
end

def my_read_count(read)
    read.length
end

def count_my_books(active_user)
    active_user.books.length
end

def my_average_shelf_count(active_user)
    active_user.shelves.collect do |shelf|
        shelf.books.length
    end.sum / (active_user.shelves.length * 1.0)
end

def my_authors(active_user)
    active_user.books.collect do |book|
        book.author.name
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