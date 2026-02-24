class MessagesController < ApplicationController

  def create
    @team = Team.find(params[:id])
    @message = Message.new(message_params)
    @message.team = @team
    @message.role = "user"

    if @message.save
      response = @ruby_llm.ask(@message.content)
      Message.create(role: 'assistant', chat: @team, content: response.content)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
