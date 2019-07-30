class CreateBooks < ActiveRecord::Migration[5.2]
    def change
        create_table :books do |t|
            t.string :title
            t.string :genre
            t.integer :author_id
            t.string :api_url
        end
    end
end