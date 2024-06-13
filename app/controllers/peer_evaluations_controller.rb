class PeerEvaluationsController < ApplicationController
  before_action :set_community
  before_action :set_evaluation_items, only: [:new, :edit, :create, :update]
  before_action :set_users, only: [:new, :edit, :create, :update]

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
  end

  def edit
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
end
