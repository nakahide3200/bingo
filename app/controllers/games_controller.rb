class GamesController < ApplicationController
  before_action :authenticate_user!, only: :show

  def index
    return redirect_to(admin_games_url) if current_user&.admin?

    @games = Game.all
  end

  # play画面
  def show
    @game = Game.find(params[:id])
  end
end
