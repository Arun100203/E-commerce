class RenameColumnTypeIntoTypeinfoInType < ActiveRecord::Migration[7.1]
  def change
    rename_column :types, :type, :typeinfo
  end
end
