class UnfollowsController < ApplicationController

  def create
    current_user.unfollow!(User.find(params[:account_id]))
    render json: { status: 'ok' }
  end

end
