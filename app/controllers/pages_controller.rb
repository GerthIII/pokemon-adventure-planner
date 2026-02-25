class PagesController < ApplicationController
  def home
    @playthroughs = current_user.playthroughs if user_signed_in?
  end
end

def select_game
end
