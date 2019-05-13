class ApplicationController < ActionController::Base

  helper_method :logged_in?, :current_user

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  # def can_administer?
  #   current_user.try(User.find_admin)
  # end

  def can_administer?
    admin = User.find_admin

    if current_user == admin
      true
    else
      false
    end
  end

  def login(user)
    @current_user = user
    session[:session_token] = @current_user.reset_session_token!
  end

  def logout
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      render json: { base: ['invalid credentials']}, status: 401
    end
  end

end