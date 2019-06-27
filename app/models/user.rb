class User < ActiveRecord::Base
  has_secure_password
  has_many :catagories
  has_many :links, through :catagories


end