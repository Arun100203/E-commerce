class RenameColumnCustomerIdIntoCustomerinfoIdInTransaction < ActiveRecord::Migration[7.1]
  def change
    remove_column :transactions, :transaction_id, :integer
  end
end
