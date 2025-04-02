class PublicController < ApplicationController
  def index
    @communities = Community.all.limit(5)
    top_posts = Post.order(created_at: :desc).limit(20)
    @trending_posts = top_posts.sample(4) # Randomly select 4 from top 20
    @posts = Post.order(created_at: :desc).limit(20) # Show recent posts
    @vote = Vote.new
  end

  def profile
    @profile = Account.find_by_username params[:username]
    @posts = @profile.posts
  end
end
