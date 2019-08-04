
class CreateBucketMoments < ActiveRecord::Migration
  def change
    create_table :bucket_moments do |t|
      t.integer :to_id
      t.integer :from_id
      t.integer :moment_id
    end
  end
end
