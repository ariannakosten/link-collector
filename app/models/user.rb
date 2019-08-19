class User < ActiveRecord::Base
  has_many :links
  has_many :categories, through: :links
  
  has_secure_password
end

# has_many :categories
# has_many :links, through: :categories