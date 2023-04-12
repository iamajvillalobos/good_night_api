class Api::V1::SleepRecordsController < ApplicationController
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

  def update
    sleep_record = Current.user.sleep_records.where(clock_out: nil).last
    if sleep_record.update(clock_out: Time.current)
      render json: {message: "You are clocked out"}, status: :ok
    else
      render json: {error: sleep_record.errors}, status: :unprocessable_entity
    end
  end

  def friends_sleep_records
    one_week_ago = 1.week.ago

    sleep_records = SleepRecord
      .for_friends_of(Current.user)
      .since(one_week_ago)
      .with_user_name_and_duration
      .ordered_by_duration_desc

    render json: {data: sleep_records.map { |r| sleep_record_json(r) }}, status: :ok
  end

  private

  def sleep_record_json(sleep_record)
    {
      id: sleep_record.id,
      user_name: sleep_record.user_name,
      clock_in: sleep_record.clock_in,
      clock_out: sleep_record.clock_out,
      duration: sleep_record.clock_out - sleep_record.clock_in
    }
  end
end
