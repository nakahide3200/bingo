class Game < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :users, through: :entries

  validates :name, length: { maximum: 50 }, presence: true
  validates :start_time, presence: true

  validate :start_time_should_be_after_now, on: :create

  serialize :numbers, JSON

  def self.default_name
    'XXX ビンゴ大会'
  end

  def self.defalut_start_time
    t = Time.zone.now.advance(hours: 1)
    t - t.min * 60 - t.sec
  end

  # まだ出ていない番号を引く
  def lot_number
    ((1..75).to_a - numbers).sample
  end

  # まだビンゴしていないエントリーに対してビンゴしているかチェックする。
  # ビンゴしていたらエントリーのbingo_turnにターンをセットする。
  def check_bingo_for_entries!
    entries.includes(:card).where('entries.bingo_turn = 0').find_each do |entry|
      if entry.card.bingo?(numbers)
        entry.bingo_turn = numbers.length
        entry.save!
      end
    end
  end

  # 戻り値はハッシュ(key：ターン、value：userの配列)
  def bingo_users_for_each_turn
    users_for_each_turn = {}
    entries.includes(:user).where('entries.bingo_turn > 0').find_each do |entry|
      if users_for_each_turn[entry.bingo_turn]
        users_for_each_turn[entry.bingo_turn] << entry.user
      else
        users_for_each_turn[entry.bingo_turn] = [entry.user]
      end
    end
    users_for_each_turn
  end

  private

  def start_time_should_be_after_now
    errors.add(:start_time, 'は現在時刻以降を指定してください。') if start_time < Time.zone.now
  end
end
