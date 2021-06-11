class UsersController < ApplicationController
  before_action :require_login, only: %i[show edit update]
  before_action :set_user, only: [:show, :edit, :update]
  
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

  def edit; end

  def show 
    @user_opinions = set_user.created_opinions.ordered_by_most_recent.all
  end

  def update
    if @user.update(user_params)
      flash.keep[:notice] = 'Profile updated!'
      redirect_to edit_user_path(current_user.id)
    else
      flash.now[:message_edit] = @user.errors.full_messages
      render 'edit'
    end
  end

  def follow_user
    current_user.follow_user(params[:id])
    redirect_to user_path(params[:id])
  end

  def require_login
    redirect_to login_path unless current_user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require('user').permit(:username, :fullname)
  end
end