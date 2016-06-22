class CreateRides < ActiveRecord::Migration
  def change
      create_table :rides do |t|
      t.string :title
      t.integer :distance
      t.integer :cyclist_id
    end
  end
end
