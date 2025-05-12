class ProfilesController < ApplicationController

  def show
    @profile = current_user.prepare_profile
    @post_count = current_user.posts.count
    @followers_count = current_user.followers.count
    @following_count = current_user.followings.count
    @user_posts = current_user.posts.order(created_at: :desc)
  end

  def edit
    @profile = current_user.prepare_profile
  end

  def update
    @profile = current_user.prepare_profile
    if params[:avatar].present?
      current_user.profile.avatar.attach(params[:avatar])
      @profile.save
      render json: { message: I18n.t('profiles.update.success'), url: url_for(current_user.profile.avatar) }, status: :ok
    else
      render json: { error: I18n.t('errors.messages.file_not_found') }, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:display_name, :introduction, :avatar)
  end

end
