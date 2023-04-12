FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    auth_token { Faker::Alphanumeric.alpha(number: 10) }
  end
end
