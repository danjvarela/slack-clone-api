class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from CanCan::AccessDenied do |exception|
    render json: {message: "You have no permission to execute this action"}, status: :forbidden
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: {message: "404 not found"}, status: 404
  end
end
