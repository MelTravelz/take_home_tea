FactoryBot.define do
  factory :subscription do
    title { Faker::Space.unique.galaxy }
    price_usd { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
  end
end
