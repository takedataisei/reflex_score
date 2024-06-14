class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :user_not_found
  before_action :set_user
  before_action :authenticate_user!
  before_action :move_to_root, only: :edit
  before_action :set_community, only: :evaluations
  before_action :check_membership, only: :evaluations

  def show
    @referrer = params[:referrer]
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user, referrer: params[:referrer])
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def evaluations
    @evaluation_items = @community.evaluation_items.includes(:self_evaluations, :peer_evaluations)
    @self_evaluations = @user.self_evaluations.where(evaluation_item: @evaluation_items).order(created_at: :desc)
    @peer_evaluations_received = @user.evaluations_received.where(evaluation_item: @evaluation_items).order(created_at: :desc)
  end

  private
  def user_params
    params.require(:user).permit(:image, :username, :profile)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def move_to_root
    if @user.id != current_user.id
      redirect_to root_path
    end
  end

  def user_not_found
    flash[:alert] = "存在しないユーザーです。"
    redirect_to root_path
  end

  def set_community
    @community = Community.find(params[:community_id])
  end

  def check_membership
    unless @community.users.include?(current_user)
      flash[:alert] = 'このコミュニティに参加していません'
      redirect_to root_path
    end
  end
end
