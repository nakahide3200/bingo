class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_one :card, dependent: :destroy
end
