class Game < ApplicationRecord
  has_many :entries, dependent: :destroy

  validates :name, length: { maximum: 50 }, presence: true
  validates :start_time, presence: true

  validate :start_time_should_be_after_now

  serialize :numbers, JSON

  # まだ出ていない番号を引く
  def lot_number
    ((1..75).to_a - numbers).sample
  end

  private

  def start_time_should_be_after_now
    errors.add(:start_time, 'は現在時刻以降を指定してください。') if start_time < Time.zone.now
  end
end
