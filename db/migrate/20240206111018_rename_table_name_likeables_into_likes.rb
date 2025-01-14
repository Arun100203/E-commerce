class RenameTableNameLikeablesIntoLikes < ActiveRecord::Migration[7.1]
  def change
    rename_table :likeables, :likes if table_exists?(:likeables)
  end
end
