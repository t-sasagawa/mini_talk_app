class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "message_channel"
    # stream_from はサーバとクライアントを関連付けるメソッド。
    # ActionCableに予め用意されている。
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
