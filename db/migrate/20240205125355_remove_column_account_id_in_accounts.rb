class RemoveColumnAccountIdInAccounts < ActiveRecord::Migration[7.1]
  def change
    remove_column :accounts, :account_id, :integer
  end
end
