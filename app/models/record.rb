class Record < ActiveRecord::Base
  enum :status, [ :clocked_in, :clocked_out ]
  enum :lunch, [ :off_lunch, :on_lunch ]

  def display_status
    {
      clocked_in: "Clocked In",
      clocked_out: "Clocked Out"
    }[status.to_sym]
  end

  def display_lunch_status
    return nil unless lunch
      {
        on_lunch: "On Lunch",
        off_lunch: "Off Lunch"
      }[lunch.to_sym]
  end
end
