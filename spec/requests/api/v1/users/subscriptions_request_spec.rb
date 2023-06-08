require 'rails_helper'

RSpec.describe "/api/v1/users/:id/subscriptions" do
  describe "#index" do
    before(:each) do
      @user1 = create(:user)
      @user2 = create(:user)

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

      @user_1_sub = create(:user_subscription, user: @user1, subscription: @sub3, status: 1)
      @user_2_sub = create(:user_subscription, user: @user1, subscription: @sub1, status: 1, frequency: 2)
      @user_3_sub = create(:user_subscription, user: @user1, subscription: @sub2, status: 1, frequency: 2)
      @user_4_sub = create(:user_subscription, user: @user1, subscription: @sub1)
    end

    context "when successful" do
      let(:expected_result) do
          {
            user_subscription_id: @user_1_sub.id, 
            status: @user_1_sub.status, 
            frequency: @user_1_sub.frequency, 
            title: @sub3.title, 
            price_usd: @sub3.price_usd
          }
      end

      it "returns all subcriptions for a user" do
        get "/api/v1/users/#{@user1.id}/subscriptions"

        expect(response).to be_successful
          
        parsed_data = JSON.parse(response.body, symbolize_names: true)
        
        expect(parsed_data).to be_a(Hash)
        expect(parsed_data.keys).to eq([:data])
        expect(parsed_data[:data].keys).to eq([:id, :type, :attributes])
        expect(parsed_data[:data][:attributes].keys).to eq([:all_sub_info])

        expect(parsed_data[:data][:attributes][:all_sub_info][0]).to include(expected_result)
      end

      it "returns an empty array if a user has no subscriptions" do
        get "/api/v1/users/#{@user2.id}/subscriptions"

        expect(response).to be_successful

        parsed_data = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_data).to be_a(Hash)
        expect(parsed_data.keys).to eq([:data])
        expect(parsed_data[:data].keys).to eq([:id, :type, :attributes])
        expect(parsed_data[:data][:attributes].keys).to eq([:all_sub_info])
        expect(parsed_data[:data][:attributes][:all_sub_info]).to eq([])
      end
    end

    context "when NOT successful" do
      it "returns a 404 when user is invalid" do
        get "/api/v1/users/0099/subscriptions"

        expect(response).to have_http_status(404)

        parsed_data = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_data).to be_a(Hash)
        expect(parsed_data.keys).to eq([:errors])
        expect(parsed_data[:errors]).to be_a(Array)
        expect(parsed_data[:errors][0].keys).to eq([:status, :title, :detail])
        expect(parsed_data[:errors][0][:detail]).to eq("Couldn't find User with 'id'=0099")
      end
    end
  end

  describe "#create" do
    before(:each) do
      @user1 = create(:user)
      @user2 = create(:user)

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
    end

    describe "when successful" do
      it "creates a new user_subscription" do
        sub_params = { subscription_id: @sub1.id, frequency: 2}
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post "/api/v1/users/#{@user1.id}/subscriptions", headers:, params: JSON.generate(sub_params)

        expect(response).to be_successful
        parsed_data = JSON.parse(response.body, symbolize_names: true)
        
        expect(parsed_data).to be_a(Hash)
        expect(parsed_data.keys).to eq([:data])
        expect(parsed_data[:data].keys).to eq([:id, :type])
        expect(parsed_data[:data][:id]).to eq(UserSubscription.last.id.to_s)
      end
    end

    describe "when NOT successful" do
      it "returns 404 when user id is invalid" do
        sub_params = { subscription_id: @sub1.id, frequency: 2}
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post "/api/v1/users/0099/subscriptions", headers:, params: JSON.generate(sub_params)

        expect(response).to have_http_status(404)

        parsed_data = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_data).to be_a(Hash)
        expect(parsed_data.keys).to eq([:errors])
        expect(parsed_data[:errors]).to be_a(Array)
        expect(parsed_data[:errors][0].keys).to eq([:status, :title, :detail])
        expect(parsed_data[:errors][0][:detail]).to eq("Couldn't find User with 'id'=0099")
      end

      it "returns 404 when subscription id is invalid" do
        sub_params = { subscription_id: 55, frequency: 2}
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post "/api/v1/users/#{@user1.id}/subscriptions", headers:, params: JSON.generate(sub_params)

        expect(response).to have_http_status(404)

        parsed_data = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_data).to be_a(Hash)
        expect(parsed_data.keys).to eq([:errors])
        expect(parsed_data[:errors]).to be_a(Array)
        expect(parsed_data[:errors][0].keys).to eq([:status, :title, :detail])
        expect(parsed_data[:errors][0][:detail]).to eq("Couldn't find Subscription with 'id'=55")
      end

      xit "returns 400/404 when frequency enum is invalid" do
        sub_params = { subscription_id: @sub1.id, frequency: 8}
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post "/api/v1/users/#{@user1.id}/subscriptions", headers:, params: JSON.generate(sub_params)

        expect(response).to have_http_status(404)

        parsed_data = JSON.parse(response.body, symbolize_names: true)

        # expect(parsed_data).to be_a(Hash)
        # expect(parsed_data.keys).to eq([:errors])
        # expect(parsed_data[:errors]).to be_a(Array)
        # expect(parsed_data[:errors][0].keys).to eq([:status, :title, :detail])
        # expect(parsed_data[:errors][0][:detail]).to eq("Couldn't find User with 'id'=0099")
      end
    end
  end
end