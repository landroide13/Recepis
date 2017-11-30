class ComentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "coments"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
