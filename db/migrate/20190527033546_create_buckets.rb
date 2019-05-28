class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.integer :total
      t.integer :user_id
    end
  end
end
