class Playthrough < ApplicationRecord
  belongs_to :user
  has_many :teams, dependent: :destroy

  validates :game_version, inclusion: {}
end
