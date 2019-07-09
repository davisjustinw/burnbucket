class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.string :name
      t.boolean :potential
      t.integer :user_id
    end
  end
end
