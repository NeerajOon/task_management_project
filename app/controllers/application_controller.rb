class ApplicationController < ActionController::Base
  before_action :authenticate_user_from_token!, except: :create
  protect_from_forgery with: :null_session


  private

  def authenticate_user_from_token!
    token = request.headers['Authorization']
    if token
      @current_user = User.find_by(authentication_token: token)
      render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
    else
      render json: { error: 'Token missing' }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end
  