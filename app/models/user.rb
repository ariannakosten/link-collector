class User < ActiveRecord::Base
  has_secure_password
  # has_many :categories
  # has_many :links, through: :categories
  has_many :links
  has_many :categories, through: :links

end