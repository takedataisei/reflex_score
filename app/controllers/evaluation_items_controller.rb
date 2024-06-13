class EvaluationItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_community
  before_action :check_admin
  before_action :set_evaluation_items, except: :destroy

  def index
    @evaluation_item = @community.evaluation_items.new
  end

  def create
    @evaluation_item = @community.evaluation_items.new(evaluation_item_params)
    if @evaluation_item.save
      redirect_to community_evaluation_items_path(@community), notice: '評価項目が追加されました。'
    else
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @evaluation_item = EvaluationItem.find(params[:id])
    @self_evaluations = @evaluation_item.self_evaluations.includes(:user).order('created_at DESC')
    @peer_evaluations = @evaluation_item.peer_evaluations.includes(:user).order('created_at DESC')
  end

  def destroy
    @evaluation_item = @community.evaluation_items.find(params[:id])
    @evaluation_item.destroy
    redirect_to community_evaluation_items_path(@community), notice: '評価項目が削除されました'
  end

  private

  def set_community
    @community = Community.find(params[:community_id])
  end

  def check_admin
    membership = @community.community_memberships.find_by(user: current_user)
    unless membership&.admin?
      flash[:alert] = '編集権限がありません'
      redirect_to community_path(@community)
    end
  end

  def set_evaluation_items
    @evaluation_items = @community.evaluation_items.where.not(id: nil)
  end

  def evaluation_item_params
    params.require(:evaluation_item).permit(:name)
  end
end
