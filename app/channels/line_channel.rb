class LineChannel < ApplicationCable::Channel
  
  def subscribed
      stream_from "LineChannel"
  end

  def receive(data)
    ActionCable.server.broadcast("LineChannel", data)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
