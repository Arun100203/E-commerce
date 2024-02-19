class AddColumnCategoryIdAndTypeIdInProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :category_id, :integer
    add_column :products, :type_id, :integer
    remove_column :products, :category, :string
  end
end
