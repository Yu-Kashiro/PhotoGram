class FollowsController < ApplicationController

  def create
    user = User.find(params[:account_id])
    current_user.follow!(user)
  end

end
