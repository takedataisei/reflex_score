class SelfEvaluationsController < ApplicationController
  before_action :set_community
  before_action :set_evaluation_items
  def new
    @self_evaluation = SelfEvaluation.new
  end

  def create
    @self_evaluation = SelfEvaluation.new(self_evaluation_params)
    if @self_evaluation.save
      redirect_to community_path(@community)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def set_community
    @community = Community.find(params[:community_id])
  end

  def set_evaluation_items
    @evaluation_items = @community.evaluation_items
  end

  def self_evaluation_params
    params.require(:self_evaluation).permit(:evaluation_item_id, :score, :comment).merge(user_id: current_user.id)
  end

end
