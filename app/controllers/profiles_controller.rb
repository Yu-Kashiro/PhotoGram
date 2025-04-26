class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def show
    @post_count = current_user.posts.count
    @followers_count = current_user.followers.count
    @following_count = current_user.followings.count
    @user_posts = current_user.posts.order(created_at: :desc)
  end

  def edit
  end

  def update
    if params[:avatar].present?
      current_user.profile.avatar.attach(params[:avatar])  # 🔹 profile に avatar を設定
      @profile.save
      render json: { message: 'アップロード成功', url: url_for(current_user.profile.avatar) }, status: :ok
    else
      render json: { error: 'ファイルがありません' }, status: :unprocessable_entity
    end
  end

  private
  def set_profile
    @profile = current_user.prepare_profile
  end

  def profile_params
    params.require(:profile).permit(:display_name, :introduction, :avatar)
  end

end
