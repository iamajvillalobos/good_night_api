class Api::V1::ClockInsController < ApplicationController
  def index
    sleep_records = Current.user.sleep_records.order(:created_at)
    render json: {data: sleep_records}, status: :ok
  end

  def create
    sleep_record = Current.user.sleep_records.new(clock_in: Time.current)

    if sleep_record.save
      render json: {message: "You are clocked in", data: sleep_record},
        status: :ok
    else
      render json: {error: sleep_record.errors}, status: :unprocessable_entity
    end
  end
end
