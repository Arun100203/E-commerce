class RenameColumnFromPolymorphicIntoLikeableIdInLikes < ActiveRecord::Migration[7.1]
  def change
    rename_column :likes, :polymorphic, :likeable_type
  end
end
