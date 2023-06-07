require 'rails_helper'

RSpec.describe "/api/v1/users/:id/subscriptions" do
  describe "#index" do
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

    context "when successful" do
      it "returns all subcriptions for a user" do
        get "/api/v1/users/#{@user.id}/subscriptions"

        expect(response).to be_successful
          
        parsed_data = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_data).to be_a(Hash)
        expect(parsed_data.keys).to eq([:data])
        expect(parsed_data[:data].keys).to eq([:id, :type, :attributes])
        expect(parsed_data[:data][:attributes].keys).to eq([:all_sub_info])
        expect(parsed_data[:data][:attributes][:all_sub_info]).to be_an(Array)
        expect(parsed_data[:data][:attributes][:all_sub_info][0].keys).to eq([:user_subscription_id, 
                                                                              :status, 
                                                                              :frequency, 
                                                                              :title, 
                                                                              :price_usd])
      end
    end

    context "when NOT successful" do
      # test for invalid user id
    end
  end
end