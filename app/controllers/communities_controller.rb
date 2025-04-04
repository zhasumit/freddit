class CommunitiesController < ApplicationController
  before_action :authenticate_account!, except: [ :index, :show ]
  before_action :set_community, only: [ :show ]

  def index
    # load the communities
    @communities = Community.all
  end

  def show
    @posts = @community.posts.order(created_at: :desc)
    @subscriber_count = @community.subscribers.count
    @is_subscribed = account_signed_in? ? Subscription.where(community_id: @community.id, account_id: current_account.id).any? : false
    @subscription = Subscription.new
  end

  def new
    @community = Community.new
  end

  def create
    @community = Community.new community_values
    @community.account_id = current_account.id
    if @community.save
      redirect_to communities_path
    else
      render :new
    end
  end

  private
  def set_community
    @community = Community.find(params[:id])
  end

  def community_values
    params.require(:community).permit(:name, :url, :summary, :rules)
  end
end
