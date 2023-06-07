class UserSubscription < ApplicationRecord
  belongs_to :user
  belongs_to :subscription

  # do not need validation for status since it has a default value

  enum status: ["active", "cancelled"]
end
