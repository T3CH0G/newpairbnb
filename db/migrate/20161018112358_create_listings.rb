class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
    	t.integer :user_id
    	t.string :title
    	t.string :description
    	t.string :schedule
    	t.integer :capacity
        t.string :city
        t.integer :price
    	t.timestamps null:false
    	t.json :avatars
    end
  end
end
