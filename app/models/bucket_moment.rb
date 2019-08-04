class BucketMoment < ActiveRecord::Base
  belongs_to :bucket
  belongs_to :moment
end
