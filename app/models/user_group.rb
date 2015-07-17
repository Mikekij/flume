class UserGroup < ActiveRecord::Base
  has_many :linacs
  has_many :users
  has_many :events, :through => :linacs
  
end
