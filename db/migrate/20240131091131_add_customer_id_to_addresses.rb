class AddCustomerIdToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :customerinfo_id, :integer
  end
end
