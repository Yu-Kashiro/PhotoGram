class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.followings_posts
  end

  def new
    @post = Post.new
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, images: [])
  end

end
