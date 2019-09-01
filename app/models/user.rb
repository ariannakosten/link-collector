class User < ActiveRecord::Base
  has_many :links
  has_many :categories, through: :links
  
  has_secure_password
  
  validates :username, uniqueness: true
end
