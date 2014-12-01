class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user=(user)
    user.tap { session[:user_id] = user.id }
  end

  def current_user
    @current_user ||= User.where(id: session[:user_id]).take
  end
  helper_method :current_user

  def signed_in?
    current_user.present?
  end
  helper_method :signed_in?
end
