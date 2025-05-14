class AccountsController < ApplicationController

  def show
    @user = User.find(params[:id])

    # 自分自身のプロフィールを表示する場合は、リダイレクト
    if @user == current_user
      redirect_to profile_path
    end

    @profile = @user.profile
    @post_count = @user.posts.count
    @followers_count = @user.followers.count
    @following_count = @user.followings.count
    @user_posts = @user.posts.order(created_at: :desc)
  end

end
