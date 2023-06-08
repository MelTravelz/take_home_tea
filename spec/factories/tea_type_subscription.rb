FactoryBot.define do
  factory :tea_type_subscription do
    association :subscription
    association :tea_type
  end
end
