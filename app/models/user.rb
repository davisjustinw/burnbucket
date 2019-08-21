class User < ActiveRecord::Base
  

  validates :username, presence: true
  validates_uniqueness_of :username
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true

  has_secure_password
  has_many :buckets
  has_many :moments, -> { distinct }, through: :buckets
  has_many :bucket_lists

  def name
    username
  end
end
