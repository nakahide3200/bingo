class Game < ApplicationRecord
  has_many :entries, dependent: :destroy
end
