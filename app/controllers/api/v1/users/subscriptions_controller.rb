class Api::V1::Users::SubscriptionsController < ApplicationController
  
  def index
    user = User.find(params[:id])  
    sub_info = SubscriptionPresenter.new(user)
    render json: UserSubscriptionsSerializer.new(sub_info)
  end
end