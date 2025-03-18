class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    post.likes.create!(user_id: current_user.id)
    redirect_to root_path
  end

  # def destroy
  #   @like = Like.find(params[:id])
  #   @like.destroy
  #   redirect_to @like.post, notice: 'You unliked the post'
  # end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end