class ApplicationController < ActionController::API
  require 'easypost'  # add the gem here
  EasyPost.api_key = 'EZTK3dda544d5fec4cb780530210ecfc5d9eH73rEK906cOnBAKMM1BUKg'

  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  private

  def current_user
    @current_user ||= User.find(payload['user_id'])
  end

  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end
end
