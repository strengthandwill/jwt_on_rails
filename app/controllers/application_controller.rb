class ApplicationController < ActionController::Base
  attr_reader :current_application

  protected
  def authenticate_request!
    unless application_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_application = Application.find(auth_token[:application_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  private
  def http_token
    @http_token ||= if request.headers['Authorization'].present?
                      request.headers['Authorization'].split(' ').last
                    end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def application_id_in_token?
    http_token && auth_token && auth_token[:application_id].to_i
  end
end