class Profile::FollowingsController < Profile::ApplicationController
  def index
    @followings = current_user.followings
  end
end
