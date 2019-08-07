class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name 
      t.string :description
      t.integer :user_id  #not sure if i need this? #category_id
    end
  end
end