class Api::V1::Users::SubscriptionsController < ApplicationController
  def index
    user = User.find(params[:id])  
    sub_info = SubscriptionPresenter.new(user)
    render json: UserSubscriptionsSerializer.new(sub_info)
  end

   def create
    user = User.find(params[:id]) 
    subscription = Subscription.find(params[:subscription_id])

    new_sub = user.user_subscriptions.new(subscription_id: params[:subscription_id], frequency: params[:frequency])
    return unless new_sub.save!
    
    render json: NewSubscriptionSerializer.new(new_sub), status: :created
   end
end