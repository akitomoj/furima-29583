class MessagesController < ApplicationController
  def create
    @text = Message.create(message_params)
    if @text.save
      ActionCable.server.broadcast 'message_channel', content: @text
    end
    redirect_to "/items/#{@text.item_id}"
  end

  private

  def message_params
    params.require(:message).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end