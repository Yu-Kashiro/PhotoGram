class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    posts = current_user.followings_posts
    @timeline_posts = posts.left_joins(:likes).group(:id).order('COUNT(likes.id) DESC').limit(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to profile_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:content, images: [])
  end

end
