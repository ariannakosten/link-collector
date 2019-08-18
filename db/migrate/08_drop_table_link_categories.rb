class DropTableLinkCategories < ActiveRecord::Migration
  def change
    drop_table :link_categories
  end
end