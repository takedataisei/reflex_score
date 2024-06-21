class CommunityChannel < ApplicationCable::Channel
  def subscribed
    stream_from "community_#{params[:community_id]}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
