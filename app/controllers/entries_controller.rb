class EntriesController < ApplicationController
  before_action :authenticate_user!

  def new
    # 既に参加済み
    return redirect_to game_url(params[:game_id]) if current_user.entries.find_by(game_id: params[:game_id])

    @game = Game.find(params[:game_id])
  end

  # ゲームに参加
  def create
    # 既に参加済み
    return redirect_to game_url(params[:game_id]) if current_user.entries.find_by(game_id: params[:game_id])

    entry = current_user.entries.build do |e|
      e.game_id = params[:game_id]
    end
    if entry.save
      flash[:notice] = 'ゲームに参加しました。'
      redirect_to game_url(params[:game_id])
    else
      render :new
    end
  end

  def destroy
    entry = current_user.entries.find_by!(game_id: params[:game_id])
    entry.destroy!
    redirect_to games_url, notice: 'ゲームの参加をキャンセルしました。'
  end
end
