class PostsController < ApplicationController

  skip_before_action :require_login, only: %i[index show]
  before_action :set_post, only: %i[edit update destroy]

  def index
    @posts = Post.includes(:user).order(created_at: :desc).page(params[:page]).per(20)
  end

  def search
    @query = params[:q].to_s.strip
    @posts = Post.includes(:user).search_by_keyword(@query).order(created_at: :desc).page(params[:page])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, success: t('defaults.flash_message.created', item: Post.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_created', item: Post.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.includes(:user).find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
    @liked = logged_in? && @post.likes.exists?(user: current_user)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, success: t('defaults.flash_message.updated', item: Post.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_updated', item: Post.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    redirect_to posts_path, status: :see_other,
          success: t('defaults.flash_message.deleted', item: Post.model_name.human)
  end

  private

  def post_params
    params.expect(post: [:title, :body, :image])
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

end
