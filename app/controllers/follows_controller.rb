class FollowsController < ApplicationController

  def show
    user = User.find(params[:account_id])
    follow_status = current_user.has_followed?(user)
    render json: { hasFollowed: follow_status }
  end

  def create
    user = User.find(params[:account_id])
    current_user.follow!(user)
    render json: { status: 'ok' }
  end

end
