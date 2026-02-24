class Playthrough < ApplicationRecord
  belongs_to :user
  has_many :teams, dependent: :destroy

  GAME_VERSIONS = [
    "red",
    "blue",
    ...
  ]

  validates :game_version, inclusion: { in: GAME_VERSIONS }
end
