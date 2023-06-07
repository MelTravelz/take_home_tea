class Subscription < ApplicationRecord
  has_many :user_subscriptions
  has_many :users, through: :user_subscriptions

  validates :title, presence: true, uniqueness: true
  validates :price_usd, presence: true, numericality: true

  enum frequency: ["monthly", "bi-monthly", "quarterly"]
end
