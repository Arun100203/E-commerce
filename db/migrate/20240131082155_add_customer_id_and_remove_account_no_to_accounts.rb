class AddCustomerIdAndRemoveAccountNoToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :customerinfo_id, :integer

    remove_column :accounts, :Account_no, :string
    add_column :accounts, :account_no, :integer
  end
end
