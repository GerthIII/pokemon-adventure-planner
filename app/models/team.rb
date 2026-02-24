class Team < ApplicationRecord
  belongs_to :playthrough
  has_many :messages
  has_many :team_members
  has_many :pokemons, through: :team_members

  validates :name, presence: true
end
