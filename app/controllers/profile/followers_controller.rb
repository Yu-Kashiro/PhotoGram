class Profile::FollowersController < Profile::ApplicationController
  def index
    @followers = current_user.followers
  end
end