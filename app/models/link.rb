class Link < ActiveRecord::Base
 # belongs_to :categoryuser 
 belongs_to :user 
 has_many :link_categories
 has_many :categories, through: :link_categories
end

  