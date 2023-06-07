require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "relationships" do
    it { should have_many :user_subscriptions }
    it { should have_many(:users).through(:user_subscriptions) }
  end

  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_uniqueness_of :title }
    
    it { should validate_presence_of :price_usd }
    it { should validate_numericality_of :price_usd }
  end

  describe "enums" do
    it { should define_enum_for(:frequency).with_values(["monthly", "bi-monthly", "quarterly"]) }
  end
end
