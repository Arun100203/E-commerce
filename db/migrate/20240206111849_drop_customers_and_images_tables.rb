class DropCustomersAndImagesTables < ActiveRecord::Migration[7.1]
  def change
    drop_table :customers, if_exists: true
    drop_table :images, if_exists: true
  end
end
