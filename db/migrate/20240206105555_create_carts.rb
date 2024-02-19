class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.references :product, null: false, foreign_key: true
      t.references :customerinfo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
