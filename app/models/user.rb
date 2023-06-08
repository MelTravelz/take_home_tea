class User < ApplicationRecord
  has_many :user_subscriptions
  has_many :subscriptions, through: :user_subscriptions

  validates_presence_of :first_name, 
                        :last_name, 
                        :email,
                        :street_address,
                        :city,
                        :state,
                        :zip_code
  validates_uniqueness_of :email 
end
