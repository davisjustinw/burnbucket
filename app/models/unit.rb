class Unit < ActiveRecord::Base

  validates :name, presence: true
  has_many :buckets
  
end
