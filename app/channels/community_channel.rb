class CommunityChannel < ApplicationCable::Channel
  def subscribed
    stream_from "community_#{params[:community_id]}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    user = User.find(data['user_id'])
    message = Message.create!(content: data['content'], user: user, community_id: params[:community_id])
    ActionCable.server.broadcast("community_#{params[:community_id]}", {
      message: render_message(message)
    })
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end
