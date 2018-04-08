class Admin::GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user

  before_action :set_game, only: %i[show create_number edit update destroy]

  def index
    @games = Game.all
  end

  # 抽選画面
  def show
    @bingo_users_for_each_turn = @game.bingo_users_for_each_turn
  end

  # 抽選
  def create_number
    new_number = @game.lot_number

    return redirect_to [:admin, @game], notice: '全ての数が出ました。' unless new_number

    Game.transaction do
      @game.numbers << new_number
      @game.save!

      @game.check_bingo_for_entries!
    end

    @bingo_users_for_each_turn = @game.bingo_users_for_each_turn
  end

  def new
    @game = Game.new
    @game.name = Game.default_name
  end

  def edit; end

  def create
    @game = Game.new(game_params)
    @game.numbers = []

    if @game.save
      redirect_to [:admin, @game], notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  def update
    if @game.update(game_params)
      redirect_to [:admin, @game], notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @game.destroy
    redirect_to admin_games_url, notice: 'Game was successfully destroyed.'
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:name, :start_time)
  end
end
