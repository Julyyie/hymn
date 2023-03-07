class Song < ApplicationRecord
  belongs_to :game
  has_many :answers, dependent: :destroy
end
