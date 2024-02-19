class CreateLikes < ActiveRecord::Migration[7.1]
  def up
    create_table :likes do |t|
      t.references :likeable, null: false
      t.string :polymorphic
      t.references :customerinfo, null: false, foreign_key: true
      t.timestamps
    end
  end

  def down
    drop_table :likes
  end
end
