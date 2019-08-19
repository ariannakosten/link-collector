class ChangeCategoriesTable < ActiveRecord::Migration
  def change
    rename_table :categories, :category
  end
end