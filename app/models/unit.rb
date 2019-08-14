class Unit < ActiveRecord::Base

  validates :name, presence: true
  has_many :buckets
  #has_many :buckets, through: :moments


end
