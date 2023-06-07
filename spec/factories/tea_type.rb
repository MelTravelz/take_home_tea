FactoryBot.define do
  factory :tea_type do
    title { Faker::Tea.unique.variety }
    description { Faker::Tea.type }
    temperature_F { Faker::Number.within(range: 140..212) }
    brew_time_minutes { Faker::Number.between(from: 3, to: 7) }
  end
end
