class Card < ApplicationRecord
  belongs_to :entry

  serialize :numbers, JSON

  FREE_SPOT_NUMBER = 0
  FREE_SPOT_NUMBER.freeze

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
      .tap { |table| table[2][2] = 0 }
      .transpose
  end

  # TODO 高速化
  def bingo?(lot_numbers)
    # 各行のチェック
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

    # 各列のチェック
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

    # 左上斜め
    success = true
    (0..4).each do |n|
      unless hit_number?(n, n, lot_numbers)
        success = false
        break
      end
    end
    return true if success

    # 右上斜め
    success = true
    (0..4).each do |n|
      unless hit_number?(n, 4 - n, lot_numbers)
        success = false
        break
      end
    end
    return true if success

    false
  end

  private 

  def hit_number?(row, col, lot_numbers)
    lot_numbers.include?(numbers[row][col]) || numbers[row][col] == FREE_SPOT_NUMBER
  end
end
