class Playthrough < ApplicationRecord
  belongs_to :user
  has_many :teams, dependent: :destroy

  GAME_VERSIONS = [
    "firered",
    "leafgreen",
  ]

  validates :game_version, presence: true
  validates :game_version, inclusion: { in: GAME_VERSIONS, message: "%{value} is not a valid game version" }
end
