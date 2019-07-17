class Unit < ActiveRecord::Base

  validates :name, presence: true
  has_many :moments
  has_many :buckets, through: :moments
end
