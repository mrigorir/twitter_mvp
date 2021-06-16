class OpinionsController < ApplicationController
  before_action :require_login, only: %i[create show index]

  def create
    @opinion = Opinion.new(opinion_param)
    @opinion.author_id = current_user.id

    if @opinion.save
      current_user.opinion_count += 1
      current_user.save
      flash[:notice] = 'Tweet created!'
    else
      flash[:alert] = @opinion.errors.full_messages.join
    end
    redirect_to home_path
  end

  def show
    @opinion = Opinion.find(params[:id])
    # @opinion.increment!(:opinion_count)
  end

  def index
    @opinion = Opinion.new
    @opinions = Opinion.newsfeed_opinions
  end

  def require_login
    redirect_to login_path unless current_user
  end

  private

  def opinion_param
    params.require('opinion').permit(:text)
  end
end
