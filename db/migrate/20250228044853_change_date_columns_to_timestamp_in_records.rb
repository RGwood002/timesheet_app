class ChangeDateColumnsToTimestampInRecords < ActiveRecord::Migration[8.0]
  def change
    change_column :records, :creation_date, :timestamp
    change_column :records, :check_in, :timestamp
    change_column :records, :check_out, :timestamp
    change_column :records, :lunch_start, :timestamp
    change_column :records, :lunch_end, :timestamp
  end
end
