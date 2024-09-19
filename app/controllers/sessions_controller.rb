class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    byebug
    if user&.valid_password?(params[:password])
      render json: { token: user.authentication_token, email: user.email }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    user = User.find_by(authentication_token: request.headers['Authorization'])
    if user
      user.update(authentication_token: nil)
      head :no_content
    else
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
end
