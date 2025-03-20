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
        format.html { redirect_to records_path, alert: "Failed to clock in..." }
      end
    end
  end

  def clock_out
    Rails.logger.info("We are clocking out")
    @record = Record.order(created_at: :desc).first
    @record.update(clock_out_params)
    if @record.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to records_path, notice: "Clocked Out" }
      end
    else
      respond_to do |format|
        format.html { redirect_to records_path, notice: "Failed to clock out" }
      end
    end
  end

  def lunch_in
    Rails.logger.info("Going on a Lunch Break")
    @record = Record.order(created_at: :desc).first
    @record.update(lunch_in_params)

    if @record.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to records_path, notice: "Lunch Started" }
      end
    else
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to records_path, alert: "Failed to start lunch" }
      end
    end
  end

  def lunch_out
    Rails.logger.info("Coming back from lunch")
    @record = Record.order(created_at: :desc).first
    @record.update(lunch_out_params)

    if @record.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to records_path, notice: "Returned from lunch" }
      end
    else
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to records_path, alert: "Failed to end lunch" }
      end
    end
  end


  private

  def get_status
    latest_record = Record.order(created_at: :desc).first
    @status = latest_record&.display_status
    @lunch_status = latest_record&.display_lunch_status
    @is_on_lunch = latest_record&.on_lunch?
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
      status: :clocked_in,
      created_at: Time.now,
      lunch: :off_lunch
    }
  end

  def clock_out_params
    {
      status: :clocked_out,
      check_out: Time.now,
      updated_at: Time.now,
      lunch: :off_lunch
    }
  end

  def lunch_in_params
    {
      lunch: :on_lunch,
      updated_at: Time.now,
      lunch_start: Time.now
    }
  end

  def lunch_out_params
    {
      lunch: :off_lunch,
      updated_at: Time.now,
      lunch_end: Time.now
    }
  end
end
