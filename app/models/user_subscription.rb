class UserSubscription < ApplicationRecord
  belongs_to :user
  belongs_to :subscription

  # do not need validation for status or frequency since they have a default value

  enum status: ["active", "cancelled"]
  enum frequency: ["monthly", "bi-monthly", "quarterly"]

  delegate :title, :price_usd, to: :subscription 
  # this is the concept of delegation:
  # def title
  #   subscription.title
  # end
  # def price_usd
  #   subscription.price_usd
  # end
end
