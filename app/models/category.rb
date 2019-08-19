class Category < ActiveRecord::Base
  has_many :links
  has_many :users, through: :links
end