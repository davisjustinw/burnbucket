class Moment < ActiveRecord::Base

  validates :memo, presence: true

  belongs_to :user
  has_many :bucket_moments
  has_many :buckets, through: :bucket_moments
  belongs_to :unit

end
