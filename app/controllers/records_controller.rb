class RecordsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_records_without_checkout, only: [ :create ]
  def index
    @records = Record.all
  end

  def create
    @record = Record.new(record_params)
    if @record.save
      redirect_to @record, notice: "Record was successfully created."
    else
      render :new
    end
  end


  private

  def check_records_without_checkout
    records_without_checkout = Record.where(check_out: nil)
    if records_without_checkout.exists?
      render json: { error: "There are records without check_out", status: :unprocessable_entity }
    end
  end

  def record_params
    params.require(:record).permit(:creation_date, :check_in, :created_at, :updated_at)
  end
end
