class CommunitiesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_community, only: [:show, :edit, :update, :leave]
  before_action :check_membership, only: [:show, :edit, :update, :leave]
  rescue_from ActiveRecord::RecordNotFound, with: :community_not_found

  def index
    if user_signed_in?
      @communities = current_user.communities
    end
  end

  def new
    @community = Community.new
  end

  def create
    @community = Community.new(community_params)
    if @community.save
      redirect_to community_path(@community.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def join
    @community = Community.new
  end

  def process_join
    @community = Community.find_by(name: params[:name])

    if @community && @community.authenticate(params[:password])
      if @community.users.include?(current_user)
        flash.now[:alert] = 'すでにこのコミュニティに参加しています'
        render_flash
      else
        CommunityMembership.create(user_id: current_user.id, community_id: @community.id, role: :member)
        redirect_to community_path(@community.id)
      end
    else
      flash.now[:alert] = 'コミュニティ名またはパスワードが正しくありません'
      render_flash
    end
  end

  def show
  end

  def leave
    membership = current_user.community_memberships.find_by(community: @community)
    if membership
      membership.destroy
      flash[:notice] = 'コミュニティを抜けました'
      redirect_to root_path
    else
      flash[:alert] = 'コミュニティを抜けられませんでした'
      redirect_to community_path(@community)
    end
  end

  def edit
  end

  def update
    if @community.update(community_params)
      update_memberships
      redirect_to community_path(@community)
    else
      flash.now[:alert] = '更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def community_params
    params.require(:community).permit(:name, :password, :password_confirmation, :description, user_ids:[])
  end

  def render_flash
    render turbo_stream: turbo_stream.update("flash", partial: "shared/flash")
  end
  
  def set_community
    @community = Community.find(params[:id])
  end

  def update_memberships
    params[:community][:memberships].each do |id, membership_params|
      membership = @community.community_memberships.find(id)
      membership.update(role: membership_params[:role])
    end
  end

  def check_membership
    unless @community.users.include?(current_user)
      flash[:alert] = 'このコミュニティに参加していません'
      redirect_to root_path
    end
  end

  def community_not_found
    flash[:alert] = "存在しないコミュニティです。"
    redirect_to root_path
  end
end
