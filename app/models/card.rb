class Card < ApplicationRecord
  belongs_to :entry

  def numbers
    return @numbers if @numbers
    @numbers = Card.deserialize_numbers(serialized_numbers)
    @numbers
  end

  def self.generate_and_serialize_numbers
    serialize_numbers(generate_numbers)
  end

  private_class_method :generate_numbers

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

  def self.serialize_numbers(numbers)
    JSON.fast_generate(numbers)
  end

  def self.deserialize_numbers(serialized_numbers)
    JSON.parse(serialized_numbers)
  end
end
