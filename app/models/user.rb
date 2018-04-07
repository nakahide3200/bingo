class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :entries, dependent: :nullify

  def registered_for_game?(game_id)
    entries.where(game_id: game_id).exists?
  end
end
