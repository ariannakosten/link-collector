class User < ActiveRecord::Base
  has_secure_password
  # has_many :categories
  # has_many :links, through: :categories
  has_many :links
  has_many :categories, through: :links
  
  
  
  # def links_sort_by_name
  #   self.links.all.sort_by {|link| link[:link_name]}
  # end

end