class UsersController < ApplicationController
  before_action :require_login, only: %i[show follow_user edit update]
  before_action :set_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to home_path
    else
      flash.now[:error_messages] = @user.errors.full_messages
      render 'new'
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def show
    @user_opinions = set_user.created_opinions.ordered_by_most_recent.all
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = 'Profile updated!'
      redirect_to user_path(current_user.id)
    else
      flash.now[:message_edit] = @user.errors.full_messages
      render 'edit'
    end
  end

  def follow_this_user
    current_user.follow_user(params[:id])
    redirect_to user_path(params[:id])
    flash[:notice] = 'Great, user followed!'
  end

  def unfollow_this_user
    current_user.unfollow_user(params[:id])
    redirect_to user_path(params[:id])
    flash[:alert] = 'You are not following this user anymore!'
  end

  def require_login
    redirect_to login_path unless current_user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require('user').permit(:username, :fullname, :avatar)
  end
end
