class Api::V1::FeedsController < ApplicationController
  def index
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
