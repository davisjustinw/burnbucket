class Bucket < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

  validates :name, presence: true

  belongs_to :user
  has_many :entries
end
