class User < ActiveRecord::Base
  has_many :links
  has_many :catagories, through :links


end