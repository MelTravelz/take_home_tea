require 'rails_helper'

RSpec.describe SubscriptionPresenter do
  describe "instance methods" do
    before(:each) do
      @user = create(:user)

      @sub1 = create(:subscription)
      @sub2 = create(:subscription)
      @sub3 = create(:subscription)

      @tea1 = create(:tea_type)
      @tea2 = create(:tea_type)
      @tea3 = create(:tea_type)

      @subs1_tea1 = create(:tea_type_subscription, subscription: @sub1, tea_type: @tea1)
      @subs1_tea2 = create(:tea_type_subscription, subscription: @sub1, tea_type: @tea2)

      @subs2_tea2 = create(:tea_type_subscription, subscription: @sub2, tea_type: @tea2)
      @subs2_tea3 = create(:tea_type_subscription, subscription: @sub2, tea_type: @tea3)

      @subs3_tea3 = create(:tea_type_subscription, subscription: @sub3, tea_type: @tea3)
      @subs3_tea1 = create(:tea_type_subscription, subscription: @sub3, tea_type: @tea1)

      @user_1_sub = create(:user_subscription, user: @user, subscription: @sub3, status: 1)
      @user_2_sub = create(:user_subscription, user: @user, subscription: @sub1, status: 1, frequency: 2)
      @user_3_sub = create(:user_subscription, user: @user, subscription: @sub2, status: 1, frequency: 2)
      @user_4_sub = create(:user_subscription, user: @user, subscription: @sub1)
    end

    let(:user_sub_all_info) { SubscriptionPresenter.new(@user) }

    describe "#initialize" do
      it "can create a SubscriptionPresenter object" do
        expect(user_sub_all_info).to be_a(SubscriptionPresenter)
        expect(user_sub_all_info.id).to eq(nil)
        expect(user_sub_all_info.all_sub_info).to be_an(Array)
        expect(user_sub_all_info.all_sub_info[0]).to be_a(Hash)
        expect(user_sub_all_info.all_sub_info[0].keys).to eq([:user_subscription_id, :status, :frequency, :title, :price_usd])
      end
    end
  end
end