class BucketList < ActiveRecord::Base

  validates :name, presence: true

  belongs_to :user

  has_many :buckets
  has_many :moments, through: :buckets
  has_many :units, -> { distinct }, through: :buckets
  

  def sum
    moments.sum "value"
  end

end
