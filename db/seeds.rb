user1 = User.create!(name: "AJ")
user2 = User.create!(name: "Bobby")
user3 = User.create!(name: "Cindy")

SleepRecord.create!(user_id: user1.id, clock_in: 1.day.ago, clock_out: 1.day.ago + 8.hours)
SleepRecord.create!(user_id: user2.id, clock_in: 1.day.ago, clock_out: 1.day.ago + 8.hours)
SleepRecord.create!(user_id: user3.id, clock_in: 1.day.ago, clock_out: 1.day.ago + 8.hours)
SleepRecord.create!(user_id: user2.id, clock_in: 2.days.ago, clock_out: 2.days.ago + 8.hours)
SleepRecord.create!(user_id: user3.id, clock_in: 2.days.ago, clock_out: 2.days.ago + 8.hours)

Follow.create!(follower_id: user1.id, followee_id: user2.id)
Follow.create!(follower_id: user1.id, followee_id: user3.id)
