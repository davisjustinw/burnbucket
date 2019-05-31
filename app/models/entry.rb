class Entry < ActiveRecord::Base

  validates :name, presence: true

  belongs_to :bucket
end
