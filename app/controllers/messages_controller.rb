class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_community
  before_action :check_membership

  def index
    @messages = @community.messages.includes(:user)
  end

  def create
    @message = @community.messages.new(message_params)
    @message.user = current_user

    if @message.save
      ActionCable.server.broadcast "community_#{@community.id}_channel", {
        message: render_message(@message)
      }
      head :ok
    else
      render json: { error: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_community
    @community = Community.find(params[:community_id])
  end

  def check_membership
    unless @community.users.include?(current_user)
      flash[:alert] = 'このコミュニティに参加していません'
      redirect_to root_path
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def render_message(message)
    MessagesController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end
