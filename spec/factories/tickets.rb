FactoryBot.define do
  factory :ticket do
    info { Faker::Lorem.sentence }
    currency { "EUR" }
    price { Faker::Number.decimal(r_digits: 2) }
    available_quantity { Faker::Number.between(from: 0, to: 20).to_i }
    event { create(:event) }
  end
end
