# Create users
5.times do
  User.create(name: Faker::Name.name, auth_token: SecureRandom.hex(32))
end

# Create follows
users = User.all
users.each do |follower|
  followees = users.reject { |user| user == follower }
  followees.sample(rand(users.count)).each do |followee|
    Follow.create(follower: follower, followee: followee)
  end
end

# Create sleep records
users.each do |user|
  10.times do
    clock_in = Faker::Time.between(from: 1.week.ago, to: Time.current)
    duration = rand(1..8).hours
    clock_out = clock_in + duration
    user.sleep_records.create(clock_in: clock_in, clock_out: clock_out)
  end
end
