
class SessionsController < ApplicationController
  
  def new; end

  def create
    @user = User.find_by(session_param)
    if @user
      login(@user)
      flash[:notice] = "You signed in successfully."
      redirect_to home_path
    else
      flash.now[:alert] = 'Username does not exist in our database'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to login_path
  end

  private

  def session_param
    params.require('session').permit(:username)
  end
end