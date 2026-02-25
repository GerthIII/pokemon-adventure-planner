class PlaythroughsController < ApplicationController
  def show
    @playthrough = Playthrough.includes(:teams).find(params[:id])
  end
end
