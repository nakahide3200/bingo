class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications_channel_#{params['game_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def notify_lot(data)
    ActionCable.server.broadcast "notifications_channel_#{data['game_id']}", nil
  end
end
