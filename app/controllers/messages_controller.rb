class MessagesController < ApplicationController
  def new
    @messages = Message.all
    @message = Message.new
    # new.html.erbで保存されているメッセージをすべて表示させたいので、3行目で取得
  end

  def create
    @message = Message.new(text: params[:message][:text])
    if @message.save
      ActionCable.server.broadcast 'message_channel', content: @message
      # broadcastとは、サーバーから送られるデータの経路のこと。broadcastを介してデータ(@message)をクライアント(message_channel)に送信する。送信された情報は、message_channel.jsで受け取る。
    end
  end
end