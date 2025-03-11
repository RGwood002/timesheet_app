class CreateRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :records do |t|
      t.timestamp :creation_date
      t.timestamp :check_in
      t.timestamp :check_out
      t.timestamp :lunch_start
      t.timestamp :lunch_end
      t.string :status

      t.timestamps
    end
  end
end
