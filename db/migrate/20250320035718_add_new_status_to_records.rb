class AddNewStatusToRecords < ActiveRecord::Migration[8.0]
  def change
    add_column :records, :lunch, :integer, default: nil
  end
end
