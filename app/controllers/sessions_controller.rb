class SessionsController < ApplicationController
  def new
  end

  def create
    @user = Authenticator.find_or_create_by_auth_hash(session_params)
    self.current_user = @user
    redirect_to session.delete(:return_url) || root_path, notice: 'You have been signed in.'
  end

  def destroy
    reset_session

    redirect_to root_path, notice: 'You have been logged out.'
  end

  def failure
    reset_session

    redirect_to root_path, alert: "Authentication error with upstream provider: #{params[:message]}"
  end

  private

  def session_params
    request.env['omniauth.auth']
  end
end
