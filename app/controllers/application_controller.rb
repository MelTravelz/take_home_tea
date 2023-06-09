class ApplicationController < ActionController::API
  before_action :check_user_exists
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  rescue_from ArgumentError, with: :handle_argument_error
  # If you wanted to change the error type: (Also see the #create action & subscription.rb)
  # rescue_from ::Subscription::TeaPotError, with: :handle_hot_tea_pot

  def check_user_exists 
    @user = User.find(params[:id]) 
  end

  def handle_record_not_found(exception)
    render json: ErrorSerializer.new(exception, 404).serializable_hash, status: :not_found # 404
  end

  def handle_argument_error(exception)
    render json: ErrorSerializer.new(exception, :unprocessable_entity).serializable_hash, status: :unprocessable_entity # 422
  end

  # If you wanted to change the error type: (Also see the #create action & subscription.rb)
  # def handle_hot_tea_pot(exception)
  #   render json: ErrorSerializer.new(exception, 418).serializable_hash, status: 418 # 418
  # end
end
