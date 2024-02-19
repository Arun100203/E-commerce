class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.integer :account_id
      t.string :Account_no
      t.string :ifsc
      t.string :bank_name

      t.timestamps
    end
  end
end
