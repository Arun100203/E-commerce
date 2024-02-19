class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :brand
      t.decimal :price
      t.integer :total_stock_amount

      t.timestamps
    end
  end
end
