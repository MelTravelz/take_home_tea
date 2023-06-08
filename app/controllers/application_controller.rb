class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  rescue_from ArgumentError, with: :handle_argument_error

  def handle_record_not_found(exception)
    render json: ErrorSerializer.new(exception, 404).serializable_hash, status: :not_found # 404
  end

  def handle_argument_error(exception)
    render json: ErrorSerializer.new(exception, :unprocessable_entity).serializable_hash, status: :unprocessable_entity
  end
end
