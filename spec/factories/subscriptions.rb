FactoryBot.define do
  factory :subscription do
    title { "MyString" }
    price_usd { 1.5 }
    frequency { 1 }
  end
end
