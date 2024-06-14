class SelfEvaluationsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :self_evaluation_not_found
  before_action :authenticate_user!
  before_action :set_community
  before_action :set_evaluation_items, only: [:new, :edit, :create, :update]
  before_action :set_self_evaluation, only: [:edit, :update, :destroy]
  before_action :check_membership
  before_action :check_contributor, only: [:edit, :update, :destroy]

  def index
    @self_evaluations = current_user.self_evaluations.order('created_at DESC')
  end

  def new
    @self_evaluation = SelfEvaluation.new
  end

  def create
    @self_evaluation = SelfEvaluation.new(self_evaluation_params)
    if @self_evaluation.save
      redirect_to community_self_evaluations_path(@community)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @self_evaluation.update(self_evaluation_params)
      redirect_to community_self_evaluations_path(@community)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @self_evaluation.destroy
    redirect_to community_self_evaluations_path(@community), notice: '自己評価が削除されました'
  end

  private
  def set_community
    @community = Community.find(params[:community_id])
  end

  def set_evaluation_items
    @evaluation_items = @community.evaluation_items
  end

  def set_self_evaluation
    @self_evaluation = SelfEvaluation.find(params[:id])
  end

  def self_evaluation_params
    params.require(:self_evaluation).permit(:evaluation_item_id, :score, :comment).merge(user_id: current_user.id)
  end

  def check_membership
    unless @community.users.include?(current_user)
      flash[:alert] = 'このコミュニティに参加していません'
      redirect_to root_path
    end
  end

  def check_contributor
    if @self_evaluation.user_id != current_user.id
      redirect_to community_self_evaluations_path(@community)
    end
  end

  def self_evaluation_not_found
    flash[:alert] = '存在しない他者評価です。'
    redirect_to community_self_evaluations_path(@community)
  end

end
