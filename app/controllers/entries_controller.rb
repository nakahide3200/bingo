class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :confirm_not_admin

  def new
    # 既に参加済み
    return redirect_to game_url(params[:game_id]) if current_user.registered_for_game?(params[:game_id])

    @game = Game.find(params[:game_id])
  end

  # ゲームに参加
  def create
    # 既に参加済み
    return redirect_to game_url(params[:game_id]) if current_user.registered_for_game?(params[:game_id])

    Entry.transaction do
      entry = current_user.entries.build(game_id: params[:game_id])
      entry.save!

      card = entry.build_card(numbers: Card.generate_numbers)
      card.save!
    end
    flash[:notice] = 'ゲームに参加しました。'
    redirect_to game_url(params[:game_id])
  rescue StandardError
    redirect_to games_url, notice: 'ゲームに参加できませんでした。'
  end

  def destroy
    entry = current_user.entries.find_by!(game_id: params[:game_id])
    entry.destroy!
    redirect_to games_url, notice: 'ゲームの参加をキャンセルしました。'
  end

  private

  # 管理者はゲームに参加できない
  def confirm_not_admin
    return redirect_to root_url, notice: '管理者はゲームに参加できません。' if current_user.admin?
  end
end
