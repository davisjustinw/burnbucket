class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name 
    end
  end
end
