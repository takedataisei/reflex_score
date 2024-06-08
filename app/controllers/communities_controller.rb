class CommunitiesController < ApplicationController
  def index
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

  private
  def community_params
    params.require(:community).permit(:name, :password, :password_confirmation, :description, user_ids:[])
  end
end
