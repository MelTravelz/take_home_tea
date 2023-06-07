require 'rails_helper'

RSpec.describe UserSubscription, type: :model do
  describe "relationships" do
    it { should belong_to :user }
    it { should belong_to :subscription }
  end

  describe "enums" do
    it { should define_enum_for(:status).with_values(["active", "cancelled"]) }
    it { should define_enum_for(:frequency).with_values(["monthly", "bi-monthly", "quarterly"]) }
  end
end
