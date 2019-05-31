class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.integer :amount
      t.integer :bucket_id
    end
  end
end
