

class CreateMoments < ActiveRecord::Migration
  def change
    create_table :moments do |t|
      t.string :memo
      t.integer :value
      t.integer :unit_id
    end
  end
end
