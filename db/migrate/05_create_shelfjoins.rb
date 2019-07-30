class CreateShelfjoins < ActiveRecord::Migration[5.2]
    def change
        create_table :shelfjoins do |t|
            t.integer :shelf_id
            t.integer :book_id
        end
    end
end