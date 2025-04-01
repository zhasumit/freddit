class PostsController < ApplicationController
  before_action :authenticate_account!, except: [ :index, :show ]
  before_action :set_post, only: [ :show, :destroy ]  # Added :destroy here
  before_action :auth_subscriber, only: [ :new ]
  before_action :correct_account, only: [ :destroy ]  # New authorization for delete

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @community = Community.find(params[:community_id])
    @post = Post.new
  end

  def create
    @post = Post.new(post_values)
    @post.account_id = current_account.id
    @post.community_id = params[:community_id]

    if @post.save
      redirect_to community_path(@post.community_id), notice: "Post created successfully"
    else
      @community = Community.find(params[:community_id])
      render :new
    end
  end

  def destroy
    community_id = @post.community_id
    @post.destroy
    redirect_to community_path(community_id), notice: "Post deleted successfully"
  end

  private

  def set_post
    @post = Post.includes(:comments).find(params[:id])
  end

  def auth_subscriber
    unless Subscription.where(community_id: params[:community_id], account_id: current_account.id).any?
      redirect_to root_path, flash: { error: "You must be a member to create a post" }
    end
  end

  def correct_account
    unless current_account == @post.account
      redirect_to root_path, alert: "You are not authorized to perform this action"
    end
  end

  def post_values
    params.require(:post).permit(:title, :body)
  end
end
