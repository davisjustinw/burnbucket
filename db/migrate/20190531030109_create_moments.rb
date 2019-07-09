class CreateMoments < ActiveRecord::Migration
  def change
    create_table :moments do |t|
      t.string :name
      t.integer :value
      t.integer :unit_id
      t.integer :bucket_id
    end
  end
end
