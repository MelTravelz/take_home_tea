class TeaType < ApplicationRecord
  has_many :tea_type_subscriptions
  has_many :subscriptions, through: :tea_type_subscriptions

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :temperature_F, presence: true, numericality: { greater_than_or_equal_to: 140, less_than_or_equal_to: 212}      
  validates :brew_time_minutes, presence: true, numericality: { greater_than_or_equal_to: 3, less_than_or_equal_to: 7}      
end
