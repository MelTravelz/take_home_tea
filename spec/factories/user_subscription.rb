FactoryBot.define do
  factory :user_subscription do
    association :subscription
    association :user
    status { 0 }
    frequency { 0 }
  end
end
