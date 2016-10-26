class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :acts_as_bookable_booking, index: true
      t.string :braintree_payment_id
      t.string :status
      t.string :fourdigit

      t.timestamps null: false
    end
  end
end