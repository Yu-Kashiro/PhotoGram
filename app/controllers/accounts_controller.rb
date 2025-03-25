class AccountsController < ApplicationController

  def show
    @user = User.find(params[:id])
    @profile = @user.profile
    @post_count = @user.posts.count
    @followers_count = @user.followers.count
    @following_count = @user.followings.count
  end

end
