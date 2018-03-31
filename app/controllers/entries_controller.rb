class EntriesController < ApplicationController
  before_action :authenticate_user!

  def new
    @game = Game.find(params[:game_id])
  end

  def create
    @entry = current_user.entries.build do |e|
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
    ticket.destroy!
    redirect_to game_path(params[:game_id]), notice: 'ゲームの参加をキャンセルしました。'
  end
end