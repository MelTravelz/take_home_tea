FactoryBot.define do
  factory :tea_type do
    title { Faker::Tea.variety }
    description { Faker::Tea.type }
    temperature_F { Faker::Number.between(from: 140, to: 212) }
    brew_time_minutes { Faker::Number.between(from: 3, to: 7) }
  end
end
