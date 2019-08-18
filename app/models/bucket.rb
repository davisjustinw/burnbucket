class Bucket < ActiveRecord::Base

  validates :name, presence: true
  validates_uniqueness_of :name
  belongs_to :user
  has_many :moments
  belongs_to :unit
  belongs_to :bucket_list

  def sum
    moments.sum "value"
  end

end
