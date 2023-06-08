class Subscription < ApplicationRecord
  has_many :user_subscriptions
  has_many :users, through: :user_subscriptions

  validates :title, presence: true
  validates :price_usd, presence: true, numericality: true
end
