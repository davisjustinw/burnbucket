class Bucket < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

  validates :name, presence: true

  belongs_to :user
  has_many :moments

  belongs_to :unit

  def sum
    42
  end


end
