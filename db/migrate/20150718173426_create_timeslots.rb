class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
      t.integer :start_time 
      t.integer :duration
      t.integer :availability, default: 0
      t.integer :customer_count, default: 0
      t.integer :booked, default: 0

      t.timestamps null: false
    end
  end
end
