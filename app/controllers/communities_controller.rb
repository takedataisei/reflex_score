class CommunitiesController < ApplicationController
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
    @community = Community.find(params[:id])
  end

  private
  def community_params
    params.require(:community).permit(:name, :password, :password_confirmation, :description, user_ids:[])
  end

  def render_flash
    render turbo_stream: turbo_stream.update("flash", partial: "shared/flash")
  end
  
end
