require 'rails_helper'

RSpec.describe TeaType, type: :model do
  describe "relationships" do
    it { should have_many :tea_type_subscriptions }
    it { should have_many(:subscriptions).through(:tea_type_subscriptions) }
  end

  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }

    it { should validate_presence_of :temperature_F }
    it { should validate_numericality_of(:temperature_F).is_greater_than_or_equal_to(140).is_less_than_or_equal_to(212) }

    it { should validate_presence_of :brew_time_minutes }
    it { should validate_numericality_of(:brew_time_minutes).is_greater_than_or_equal_to(3).is_less_than_or_equal_to(7) }
  end

end
