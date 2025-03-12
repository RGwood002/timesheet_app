class RecordsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_records_without_checkout, only: [ :create ]
  before_action :get_status, only: [ :index ]
  def index
    @records = Record.all
  end

  def show
    @record = Record.find(params[:id])
    render json: @record.as_json(only: [ :id, :check_in ])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Record not found" }, status: :not_found
  end

  def create
    @record = Record.new(record_params)
    if @record.save
      redirect_to @record, notice: "Record was successfully created."
    else
      render :new
    end
  end

  def new
    @record = Record.new
  end

  def edit
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])
    if @record.update(record_params)
      redirect_to @record, notice: "Record updated Successfully"
    else
      render :edit
    end
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    redirect_to records_url, notice: "Record was successfully deleted"
  end

  def clock_in
    Rails.logger.info("I was hit")
    @record = Record.new(clock_in_params)
    if @record.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to records_path, notice: "Clocked In!" }
      end
    else
      respond_to do |format|
        redirect_to records_path, alert: "Failed to clock in..."
      end
    end
  end


  private

  def get_status
    puts("get_status is hit")
    latest_record = Record.order(created_at: :desc).first
    @status = latest_record.status
  end

  def check_records_without_checkout
    records_without_checkout = Record.where(check_out: nil)
    if records_without_checkout.exists?
      render json: { error: "There are records without check_out", status: :unprocessable_entity }
    end
  end

  def record_params
    params.require(:record).permit(:creation_date, :check_in, :created_at, :updated_at)
  end

  def clock_in_params
    {
      creation_date: Time.now,
      check_in: Time.now,
      status: :clock_in,
      created_at: Time.now
    }
  end
end
