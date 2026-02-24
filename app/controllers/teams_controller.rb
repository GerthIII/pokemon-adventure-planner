class TeamsController < ApplicationController

  def show
    @team = Team.find(params[:id])
    @message = Message.new
  end

end
