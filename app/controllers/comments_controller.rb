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

    # メンションされたユーザーがいる場合は、通知を送信
    mentioned_account_id = @comment.content.scan(/@(\w+)/).uniq
    mentioned_users = User.where(account_id: mentioned_account_id)
    mentioned_users.each do |mentioned_user|
      ReplyMailer.new_reply_notification(@comment, mentioned_user).deliver_later
    end

    render json: @comment
  end

  def index
    @post = Post.find(params[:post_id])
    comments = @post.comments
    respond_to do |format|
      format.html
      format.json { render json: comments }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
