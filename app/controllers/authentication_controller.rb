class AuthenticationController < ApplicationController
  def authenticate_application
    application = Application.find_for_database_authentication(email: params[:email])
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
        auth_token: JsonWebToken.encode({application_id: application.id}),
        application: {id: application.id, email: application.email}
    }
  end
end