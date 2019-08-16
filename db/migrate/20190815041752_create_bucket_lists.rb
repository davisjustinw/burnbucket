class CreateBucketLists < ActiveRecord::Migration
  def change
    create_table :bucket_lists do |t|
      t.string :name
      t.integer :user_id
    end
  end
end
