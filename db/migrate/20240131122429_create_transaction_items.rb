class CreateTransactionItems < ActiveRecord::Migration[7.1]
  def change
    create_table :transaction_items do |t|
      t.integer :product_id
      t.integer :quantity

      t.timestamps
    end
  end
end
