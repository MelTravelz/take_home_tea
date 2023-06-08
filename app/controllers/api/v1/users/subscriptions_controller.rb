class Api::V1::Users::SubscriptionsController < ApplicationController
  before_action :check_user_exists
  before_action :check_subscription_exists, only: [:create]
  before_action :check_to_update, only: [:update]

  def index
    @sub_info = SubscriptionPresenter.new(@user)
    render json: UserSubscriptionsSerializer.new(@sub_info)
  end

  def create
    @new_sub = @user.user_subscriptions.create!(subscription_id: params[:subscription_id], frequency: params[:frequency])
    render json: UserSubscriptionSerializer.new(@new_sub), status: :created
  end

  def update
    @user_sub.update(frequency: params[:frequency], status: params[:status]) 
    render json: UserSubscriptionSerializer.new(@user_sub), status: :created
  end

  private
  def check_user_exists 
    @user = User.find(params[:id]) 
  end

  def check_subscription_exists
    @subscription = Subscription.find(params[:subscription_id])
  end

  def check_to_update
    @user_sub = @user.user_subscriptions.find(params[:user_subscription_id])
    if @user_sub.status == "cancelled"
      render json: { errors: ['Cannot update a cancelled subscription.'] }, status: :unprocessable_entity
    end
  end
end

# Notes from instructor: 
  # in #create only need this if there's a conditional:
  # @new_sub = @user.user_subscriptions.new(subscription_id: params[:subscription_id], frequency: params[:frequency])
  # return unless @new_sub.save

  # in #update:
  # @user_sub.update(params) #Do NOT Do! -> this is why we use strong params!
  