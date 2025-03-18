class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    post.likes.create!(user_id: current_user.id)
    redirect_to root_path
  end

  def destroy
    like = current_user.likes.find_by(post_id: params[:post_id])
    like.destroy!
    redirect_to root_path
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end