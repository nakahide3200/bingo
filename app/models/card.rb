class Card < ApplicationRecord
  belongs_to :entry

  serialize :numbers, JSON

  # 数値の5x5の２次元配列
  # 1列目は1から15の中から5個
  # 2列目は16から30
  # 3列目は31から45
  # 4列目は46から60
  # 5列目は61から75
  # 中央の１マスはフリースポット -> 0で表す。
  def self.generate_numbers
    (1..75)
      .each_slice(15)
      .map { |sequence| sequence.sample(5) }
      .tap { |table| table[2][2] = self.free_spot_number }
      .transpose
  end

  def self.free_spot_number
    0
  end

  # TODO: 最適化
  def bingo?(lot_numbers)
    bingo_row?(lot_numbers) || bingo_column?(lot_numbers) || bingo_left_top?(lot_numbers) || bingo_right_top?(lot_numbers)
  end

  private

  def bingo_row?(lot_numbers)
    (0..4).each do |row|
      success = true
      (0..4).each do |col|
        unless hit_number?(row, col, lot_numbers)
          success = false
          break
        end
      end
      return true if success
    end
    false
  end

  def bingo_column?(lot_numbers)
    (0..4).each do |col|
      success = true
      (0..4).each do |row|
        unless hit_number?(row, col, lot_numbers)
          success = false
          break
        end
      end
      return true if success
    end
    false
  end

  # 左上右下斜線
  def bingo_left_top?(lot_numbers)
    (0..4).each do |n|
      return false unless hit_number?(n, n, lot_numbers)
    end
    true
  end

  # 右上左下斜線
  def bingo_right_top?(lot_numbers)
    (0..4).each do |n|
      return false unless hit_number?(n, 4 - n, lot_numbers)
    end
    true
  end

  def hit_number?(row, col, lot_numbers)
    lot_numbers.include?(numbers[row][col]) || numbers[row][col] == Card.free_spot_number
  end
end
