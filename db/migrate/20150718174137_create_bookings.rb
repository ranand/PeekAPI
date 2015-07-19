class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.belongs_to :timeslot, index: true, foreign_key: true
      t.integer :size

      t.timestamps null: false
    end
  end
end
