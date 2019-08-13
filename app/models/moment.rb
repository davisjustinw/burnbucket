class Moment < ActiveRecord::Base

  validates :memo, presence: true

  belongs_to :user
  belongs_to :bucket
  belongs_to :unit

end
