class Record < ActiveRecord::Base
  enum :status, [ :clocked_in, :clocked_out ]

  def display_status
    {
      clocked_in: "Clocked In",
      clocked_out: "Clocked Out"
    }[status.to_sym]
  end
end
