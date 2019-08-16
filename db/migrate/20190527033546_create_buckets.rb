class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.string :name
      t.integer :user_id
      t.integer :unit_id
      t.integer :size
      t.integer :bucket_list_id
    end
  end
end
