class ChangeStatusToIntegerInRecords < ActiveRecord::Migration[8.0]
  def change
    change_column :records, :status, :integer, using: 'status::integer'
  end
end
