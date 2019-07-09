class Moment < ActiveRecord::Base

  validates :name, presence: true

  belongs_to :user
  belongs_to :bucket
  belongs_to :unit
end
