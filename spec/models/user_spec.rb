require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many :user_subscriptions }
    it { should have_many(:subscriptions).through(:user_subscriptions) }
  end

  describe "validations" do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip_code }

    it { should validate_uniqueness_of :email }
  end
end
