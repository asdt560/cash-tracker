class AddColumnToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :name, :string
    add_column :categories, :icon, :string
  end
end
