class AccountsController < ApplicationController

  def show
    @user = User.find(params[:id])
    if @user == current_user
      redirect_to profile_path
    end
    @profile = @user.profile
    @post_count = @user.posts.count
    @followers_count = @user.followers.count
    @following_count = @user.followings.count
  end
end
