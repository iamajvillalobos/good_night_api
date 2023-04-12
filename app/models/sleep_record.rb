class SleepRecord < ApplicationRecord
  belongs_to :user

  scope :for_friends_of, ->(user) { joins(user: :reverse_follows).where(follows: {follower_id: user.id}) }
  scope :since, ->(time) { where("sleep_records.created_at >= ?", time) }
  scope :with_user_name_and_duration, -> {
    select("sleep_records.*, users.name as user_name, EXTRACT(EPOCH FROM (sleep_records.clock_out - sleep_records.clock_in)) as duration")
  }
  scope :ordered_by_duration_desc, -> { order("duration DESC") }
end
