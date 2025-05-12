class Accounts::FollowersController < Accounts::ApplicationController
  def index
    account = User.find(params[:account_id])
    @followers = account.followers
  end
end
