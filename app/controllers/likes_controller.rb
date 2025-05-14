class LikesController < ApplicationController

  def show
    post = Post.find(params[:post_id])
    like_status = current_user.has_liked?(post)
    render json: { hasLiked: like_status }
  end

  def create
    post = Post.find(params[:post_id])
    post.likes.create!(user_id: current_user.id)
    render json: { status: 'ok' }
  end

  def destroy
    like = current_user.likes.find_by(post_id: params[:post_id])
    like.destroy!
    render json: { status: 'ok' }
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
