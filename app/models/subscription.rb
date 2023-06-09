class Subscription < ApplicationRecord
  has_many :user_subscriptions
  has_many :users, through: :user_subscriptions

  validates :title, presence: true
  validates :price_usd, presence: true, numericality: true

  # If you wanted to change the error type: (Also see the #create action & application_controller.rb)
  # class TeaPotError < StandardError; end
end
