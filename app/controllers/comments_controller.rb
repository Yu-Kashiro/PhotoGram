class CommentsController < ApplicationController

  def new
    post = Post.find(params[:post_id])
    @comment = post.comments.build
  end

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    render json: @comment
  end

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    respond_to do |format|
      format.html # デフォルトでindex.html.erbを表示
      format.json { render json: @comments }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
