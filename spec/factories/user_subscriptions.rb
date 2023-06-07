FactoryBot.define do
  factory :user_subscription do
    user { nil }
    subscriptions { nil }
    status { 1 }
  end
end
