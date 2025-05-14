class PostsController < ApplicationController

  def index
    # フォローしているユーザーの投稿をいいね数順に、5つ取得
    posts = current_user.followings_posts
    posts_with_many_likes = posts.left_joins(:likes).group(:id).order('COUNT(likes.id) DESC').limit(5)
    # 上記の投稿を除いたランダムな投稿を5つ取得
    random_posts = Post.where.not(id: posts_with_many_likes)
                       .where.not(user_id: current_user.id)
                       .order('RANDOM()').limit(5)

    @timeline_posts = posts_with_many_likes + random_posts
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
