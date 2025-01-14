class RenameColumnPolymorphicIntoLikeableType < ActiveRecord::Migration[7.1]
  def change
    rename_column :likes, :polymorphic, :likeable_type if column_exists?(:likes, :polymorphic)
  end
end
