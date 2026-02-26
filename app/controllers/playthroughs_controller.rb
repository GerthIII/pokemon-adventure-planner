class PlaythroughsController < ApplicationController
  def index
    @playthroughs = Playthrough.all
  end

  def show
    @playthrough = Playthrough.find(params[:id])
    @team = @playthrough.teams.last
  end

  def new
    @playthrough = Playthrough.new
  end

  def create
    @playthrough = Playthrough.new(playthrough_params)
    @playthrough.user = current_user

    if @playthrough.save
      redirect_to new_playthrough_team_path(playthrough_id: @playthrough.id),
                  notice: "Playthrough created! Now, choose your starter."
    else
      render :new
    end
  end

  private

  def playthrough_params
    params.require(:playthrough).permit(:game_version)
  end
end
