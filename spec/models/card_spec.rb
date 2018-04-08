require 'rails_helper'

RSpec.describe Card, type: :model do
  before do
    @card = build(:card)
  end

  describe 'カード作成' do
    let(:numbers) { @card.numbers }

    it '5行になっていること' do
      expect(numbers.length).to eq 5
    end
    it '全ての行が5列になっていること' do
      expect(numbers.all? { |col| col.length == 5 }).to be_truthy
    end
    it '1列目の全て値が1から15のどれかの値になっていること' do
      expect(numbers.transpose[0].all? { |n| (1..15).cover?(n) }).to be_truthy
    end
    it '2列目の全て値が16から30のどれかの値になっていること' do
      expect(numbers.transpose[1].all? { |n| (16..30).cover?(n) }).to be_truthy
    end
    it '3列目の真ん中以外の全て値が31から45のどれかの値になっていること' do
      [0, 1, 3, 4].each do |index|
        expect((31..45).cover?(numbers.transpose[2][index])).to be_truthy
      end
    end
    it '4列目の全て値が46から60のどれかの値になっていること' do
      expect(numbers.transpose[3].all? { |n| (46..60).cover?(n) }).to be_truthy
    end
    it '5列目の全て値が61から75のどれかの値になっていること' do
      expect(numbers.transpose[4].all? { |n| (61..75).cover?(n) }).to be_truthy
    end
    it '全ての値が重複していないこと' do
      expect(numbers.flatten.uniq).to eq numbers.flatten
    end
  end

  describe 'ビンゴの判定' do
    let(:numbers) { @card.numbers }
    let(:transpose_numbers) { numbers.transpose }

    def add_some_and_shuffle(five_numbers)
      (five_numbers + ((1..75).to_a - five_numbers).sample(4)).shuffle
    end

    it '全ての行がビンゴすること' do
      (0..4).each do |index|
        expect(@card.bingo?(add_some_and_shuffle(numbers[index]))).to be_truthy
      end
    end
    it '全ての列がビンゴすること' do
      (0..4).each do |index|
        expect(@card.bingo?(add_some_and_shuffle(transpose_numbers[index]))).to be_truthy
      end
    end
    it '左上右下斜線がビンゴすること' do
      five_numbers = []
      (0..4).each do |index|
        five_numbers << numbers[index][index]
      end
      expect(@card.bingo?(add_some_and_shuffle(five_numbers))).to be_truthy
    end
    it '右上左下斜線がビンゴすること' do
      five_numbers = []
      (0..4).each do |index|
        five_numbers << numbers[index][4 - index]
      end
      expect(@card.bingo?(add_some_and_shuffle(five_numbers))).to be_truthy
    end
    it 'ビンゴしないこと' do
      expect(@card.bingo?((1..75).to_a - numbers.flatten)).to be_falsey
    end
  end
end
