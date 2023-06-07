require 'rails_helper'

RSpec.describe TeaTypeSubscription, type: :model do
  describe "relationships" do
    it { should belong_to :subscription }
    it { should belong_to :tea_type }
  end
end
