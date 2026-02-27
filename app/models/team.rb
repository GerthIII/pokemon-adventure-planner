class Team < ApplicationRecord
  belongs_to :playthrough
  has_many :messages
  has_many :team_members, -> { order(:id) }, dependent: :destroy
  has_many :pokemons, through: :team_members
  attr_accessor :first_pokemon_name


  accepts_nested_attributes_for :messages, reject_if: :all_blank
  validates :name, presence: true
end
