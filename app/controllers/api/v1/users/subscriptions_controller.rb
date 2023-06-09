class Api::V1::Users::SubscriptionsController < ApplicationController
  before_action :check_sub_exists, only: [:create]
  before_action :check_sub_to_update, only: [:update]

  def index
    render json: UserSubscriptionSerializer.new(@user.user_subscriptions)
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
  def check_sub_exists
    @subscription = Subscription.find(params[:subscription_id])
  end

  def check_sub_before_update
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
  
  # Phase 1 Usering Presenter:
  # def index
    # @sub_info = SubscriptionPresenter.new(@user)
    # render json: UserSubscriptionsSerializer.new(@sub_info)
  # end

  #in create at the bottom of the method
    #If you wanted to change the error type: (Also see subscription.rb & application_controller.rb)
  # rescue ArgumentError => e #<- resuce is always at the bottom of a method but inline with def
    # raise ActiveRecord::RecordInvalid, e.message #<- Here's a real example
    # raise ::Subscription::TeaPotError, e.message + ", I'm a Little TeaPot! Happy April Fools!"
    # render json: "I'm a Little TeaPot! Happy April Fools!", status: 418 #<- or you can even just render a message