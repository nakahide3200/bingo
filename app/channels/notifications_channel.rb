class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'notifications_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def notify_lot
  	ActionCable.server.broadcast 'notifications_channel', nil
  end
end
