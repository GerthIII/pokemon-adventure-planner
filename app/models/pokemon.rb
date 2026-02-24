class Pokemon < ApplicationRecord
  has_many :team_members
  has_many :teams, through: :team_members

  validates :name, presence: true
  validates :type_1, presence: true
  validates :game_version, presence: true
end
