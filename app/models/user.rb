class User < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

  validates :username, presence: true
  validates_uniqueness_of :username
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true

  has_secure_password
  has_many :buckets
  has_many :moments, through: :buckets

  def name
    username
  end
end
