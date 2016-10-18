class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
    	t.integer :user_id
    	t.string :tags
    end
  end
end
