FactoryBot.define do
  factory :sleep_record do
    clock_in { Time.current }
    clock_out { Time.current + 8.hours }
    association :user
  end
end
