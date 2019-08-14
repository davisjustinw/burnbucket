

class CreateMoments < ActiveRecord::Migration
  def change
    create_table :moments do |t|
      t.string :memo
      t.integer :value
      t.datetime :timestamp
      t.integer :bucket_id
    end
  end
end
