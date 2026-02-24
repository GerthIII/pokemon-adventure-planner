class Playthrough < ApplicationRecord
  belongs_to :user
  has_many :teams

  validates :game_version, presence: true
end
