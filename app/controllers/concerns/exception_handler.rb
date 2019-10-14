module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end

    rescue_from CardError do |e|
      render json: { message: e.message }, status: :payment_required
    end

    rescue_from PaymentError do |e|
      render json: { message: e.message }, status: :payment_required
    end
  end
end
