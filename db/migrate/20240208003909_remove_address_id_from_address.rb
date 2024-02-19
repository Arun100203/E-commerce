class RemoveAddressIdFromAddress < ActiveRecord::Migration[7.1]
  def change
    remove_column :addresses, :address_id, :integer
  end
end
