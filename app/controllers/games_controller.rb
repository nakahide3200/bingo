class GamesController < ApplicationController
  before_action :authenticate_user!, only: :show

  def index
    return redirect_to(admin_games_url) if current_user&.admin?

    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end
end
