class UserSubscription < ApplicationRecord
  belongs_to :user
  belongs_to :subscription

  # do not need validation for status or frequency since they have a default value

  enum status: ["active", "cancelled"]
  enum frequency: ["monthly", "bi-monthly", "quarterly"]
end
