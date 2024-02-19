class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.integer :address_id
      t.string :door_no
      t.string :street
      t.string :state
      t.string :country
      t.integer :pincode

      t.timestamps
    end
  end
end
