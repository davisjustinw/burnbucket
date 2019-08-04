class BucketMoment < ActiveRecord::Base
  belongs_to :to_bucket, classname: "bucket", foreign_key: "to_id"
  belongs_to :from_bucket, classname: "bucket", foreign_key: "from_id"
  belongs_to :moment
end
