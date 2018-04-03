class GamesController < ApplicationController
  before_action :authenticate_user!, only: :show

  def index
    return redirect_to(admin_games_url) if current_user&.admin?

    @games = Game.all
  end

  # play画面
  def show
    @game = Game.find(params[:id])

    card = current_user.entries.find_by(game_id: params[:id])&.card

    @numbers = card.numbers

    @bingo = card.bingo?(@game.numbers)
  end
end
