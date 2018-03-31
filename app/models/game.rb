class Game < ApplicationRecord
  has_many :entries, dependent: :destroy

  validates :name, length: { maximum: 50 }, presence: true
  validates :start_time, presence: true

  validate :start_time_should_be_after_now

  private

  def start_time_should_be_after_now
    if start_time < DateTime.now
      errors.add(:start_time, 'は現在時刻以降を指定してください。')
    end
  end
end
