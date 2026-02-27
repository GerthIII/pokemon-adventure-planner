class TeamsController < ApplicationController

  def index
    @playthrough = Playthrough.find(params[:playthrough_id])
    @teams = @playthrough.teams
  end

  def show
    @team = Team.find(params[:id])
    @playthrough = @team.playthrough
  end

  def new
    @playthrough = Playthrough.find(params[:playthrough_id])
    @team = @playthrough.teams.build
    game_version = @playthrough.game_version
    @available_pokemon = Pokemon.where(game_version: game_version)
  end

  def edit
    @team = Team.includes(:team_members).find(params[:id])
    @playthrough = @team.playthrough
    game_version = @team.playthrough.game_version
    @available_pokemon = Pokemon.where(game_version: game_version)

  end

  def create
    @playthrough = Playthrough.find(params[:playthrough_id])
    @team = @playthrough.teams.build(team_params) # associate team to playthrough

    if @team.save
      redirect_to edit_team_path(@team), notice: "Team created!"
    else
      game_version = @playthrough.game_version
      @available_pokemon = Pokemon.where(game_version: game_version)
      render :new, status: :unprocessable_content
    end
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      redirect_to team_path(@team), notice: "Team updated!"
    else
      game_version = @team.playthrough.game_version
      @available_pokemon = Pokemon.where(game_version: game_version)
      render :edit, status: :unprocessable_content
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, pokemon_ids: [], messages_attributes: [:content, :role])
  end
end
