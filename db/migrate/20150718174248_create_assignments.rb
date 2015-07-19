class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.belongs_to :timeslot, index: true, foreign_key: true
      t.belongs_to :boat, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
