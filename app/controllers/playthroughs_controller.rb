class PlaythroughsController < ApplicationController
  def index
    @playthroughs = current_user.playthroughs
  end

  def show
    @playthrough = current_user.playthroughs.find(params[:id])
    @team = @playthrough.team
  end

  def new
    @playthrough = Playthrough.new
  end

  def create
    @playthrough = current_user.playthroughs.build(playthrough_params)

    if @playthrough.save
      # ① starter取得
      starter_id = params[:starter_pokemon_id]

      # ② team作成（name必須！！）
      team = Team.create(
        playthrough: @playthrough,
        name: "#{@playthrough.game_version} Team"
      )

      # ③ starterをteam_membersに追加
      TeamMember.create(
        team: team,
        pokemon_id: starter_id
      )

      redirect_to playthrough_path(@playthrough)
    else
      render :new
    end
  end

  private

  def playthrough_params
    params.require(:playthrough).permit(:game_version)
  end
end
