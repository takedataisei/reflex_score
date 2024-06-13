class PeerEvaluationsController < ApplicationController
  before_action :set_community
  before_action :set_evaluation_items, only: [:new, :edit, :create, :update]
  before_action :set_users, only: [:new, :edit, :create, :update]
  before_action :set_peer_evaluation, only: [:edit, :update, :destroy]

  def new
    @peer_evaluation = PeerEvaluation.new
  end

  def create
    @peer_evaluation = PeerEvaluation.new(peer_evaluation_params)
    if @peer_evaluation.save
      redirect_to community_peer_evaluations_path(@community)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @peer_evaluations = PeerEvaluation.joins(:evaluation_item).where(evaluation_items: { community_id: @community.id }, evaluator: current_user).order('created_at DESC')
  end

  def edit
  end

  def update
    if @peer_evaluation.update(peer_evaluation_params)
      redirect_to community_peer_evaluations_path(@community)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @peer_evaluation.destroy
    redirect_to community_peer_evaluations_path(@community), notice: '他者評価が削除されました'
  end

  private
  def set_community
    @community = Community.find(params[:community_id])
  end

  def set_evaluation_items
    @evaluation_items = @community.evaluation_items
  end

  def set_users
    @users = @community.users.where.not(id: current_user.id)
  end

  def peer_evaluation_params
    params.require(:peer_evaluation).permit(:evaluatee_id, :evaluation_item_id, :score, :comment).merge(evaluator_id: current_user.id)
  end

  def set_peer_evaluation
    @peer_evaluation = PeerEvaluation.find(params[:id])
  end
end
