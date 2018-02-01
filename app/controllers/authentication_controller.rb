class AuthenticationController < ApplicationController
  def authenticate_application
    application = Application.find_for_database_authentication(name: params[:name])
    if application.valid_password?(params[:password])
      render json: payload(application)
    else
      render json: {errors: ['Invalid Application']}, status: :unauthorized
    end
  end

  private

  def payload(application)
    return nil unless application and application.id
    {
        auth_token: JsonWebToken.encode({application_id: application.id, created_at: Time.now.to_s}),
        application: {id: application.id, name: application.name},
    }
  end
end