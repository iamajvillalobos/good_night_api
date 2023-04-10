class Api::V1::SleepRecordsController < ApplicationController
  def create
    sleep_record = Current.user.sleep_records.new(clock_in: Time.current)

    if sleep_record.save
      render json: {message: "You are clocked in", data: sleep_record},
        status: :ok
    else
      render json: {error: sleep_record.errors}, status: :unprocessable_entity
    end
  end

  def update
    sleep_record = Current.user.sleep_records.where(clock_out: nil).last
    if sleep_record.update(clock_out: Time.current)
      render json: {message: "You are clocked out"}, status: :ok
    else
      render json: {error: sleep_record.errors}, status: :unprocessable_entity
    end
  end
end
