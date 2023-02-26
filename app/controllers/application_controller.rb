class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from CanCan::AccessDenied do |exception|
    render json: {message: "You have no permission to execute this action"}, status: :forbidden
  end
end
