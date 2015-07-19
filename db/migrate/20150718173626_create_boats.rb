class CreateBoats < ActiveRecord::Migration
  def change
    create_table :boats do |t|
      t.string :name
      t.integer :capacity
      t.boolean :used, default: false

      t.timestamps null: false
    end
  end
end
