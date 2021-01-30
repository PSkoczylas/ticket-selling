FactoryBot.define do
  factory :event do
    name { Faker::Lorem.sentence[1..50] }
    description { Faker::Lorem.sentence }
    start_date { Faker::Date.forward(days: 50) }
    start_time { Faker::Time.forward(days: 2,  period: :all) }
  end
end