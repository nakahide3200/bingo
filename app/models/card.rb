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
      .tap { |table| table[2][2] = 0 }
      .transpose
  end
end
