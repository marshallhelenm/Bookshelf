class CreateShelves < ActiveRecord::Migration[5.2]
    def change
        create_table :shelves do |t|
            t.string :name
            t.text :description
            t.integer :user_id
            #should description be optional (null by default)? is it automatically so?
        end
    end
end