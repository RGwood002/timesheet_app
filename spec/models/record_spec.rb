require 'rails_helper'

RSpec.describe Record, type: :model do
  it "is valid with valid attributes" do
    record = Record.new(creation_date: Time.now,
                        check_in: Time.now,
                        status: "CLOCKED_IN")
    expect(record).to be_valid
  end
end
