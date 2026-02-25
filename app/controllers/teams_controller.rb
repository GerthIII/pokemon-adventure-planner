class TeamsController < ApplicationController

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  # def new
  #   @team = Team.new
  # end

  # def create
  #   @team = Team.new(team_params)
  #   if @team.save
  #     puts "saved"
  #     redirect_to team_path(@chat)
  #   else
  #     puts "did not save"
  #   end
  # end

  def edit
    @team = Team.includes(:team_members).find(params[:id])
    game_version = @team.playthrough.game_version
    @available_pokemon = Pokemon.where(game_version: game_version)
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      redirect_to team_path(@team), notice: "Team updated!"
    else
      game_version = @team.playthrough.game_version
      @available_pokemon = Pokemon.where(game_version: game_version)
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, pokemon_ids: [], messages_attributes: [:content, :role])
  end

end
