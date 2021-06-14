module SessionsHelper
  def login(user)
    session[:id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:id]) if session[:id]
  end

  def not_logged_in?
    current_user.nil?
  end

  def authenticate_user
    if logged_in?
      flash[:alert] = 'You need to be logged in.'
      redirect_to login_path
    else
      return_to login_path
    end
  end

  def logout
    session.delete(:id)
  end
end
