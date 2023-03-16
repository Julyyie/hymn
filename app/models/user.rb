class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :users_games, dependent: :destroy
  has_many :games, dependent: :destroy

  has_one_attached :photo

  def find_user_game_for(game)
    users_games.find_by(game: game)
  end
end
