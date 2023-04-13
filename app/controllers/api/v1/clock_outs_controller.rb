class Api::V1::ClockOutsController < ApplicationController
  def update
    sleep_record = Current.user.sleep_records.where(clock_out: nil).last
    if sleep_record.update(clock_out: Time.current)
      render json: {message: "You are clocked out"}, status: :ok
    else
      render json: {error: sleep_record.errors}, status: :unprocessable_entity
    end
  end
end
