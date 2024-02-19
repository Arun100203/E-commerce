class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.integer :transaction_id
      t.integer :customerinfo_id
      t.integer :product_id
      t.integer :seller_id
      t.integer :account_id
      t.integer :qty
      t.integer :amount
      t.string :status
      t.string :location
      t.string :date

      t.timestamps
    end
  end
end
