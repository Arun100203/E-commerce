class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :product, null: false, foreign_key: true
      t.references :customerinfo, null: false, foreign_key: true
      t.string :body

      t.timestamps
    end
  end
end
