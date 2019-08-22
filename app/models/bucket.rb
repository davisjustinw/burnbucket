class Bucket < ActiveRecord::Base

  validates :name, presence: true
  validates_uniqueness_of :name
  validates :size, numericality: true

  belongs_to :user
  has_many :moments
  belongs_to :unit
  belongs_to :bucket_list

  def sum
    moments.sum "value"
  end

end
