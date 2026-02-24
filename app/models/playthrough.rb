GAME_VERSIONS = [
    "red",
    "blue",
    "yellow",
    "gold",
    "silver",
    "crystal",
    "ruby",
    "sapphire",
    "emerald",
    "firered",
    "leafgreen",
    "diamond",
    "pearl",
    "platinum",
    "heartgold",
    "soulsilver",
    "black",
    "white",
    "colosseum",
    "xd",
    "black-2",
    "white-2",
    "x",
    "y",
    "omega-ruby",
    "alpha-sapphire",
    "sun",
    "moon",
    "ultra-sun",
    "ultra-moon",
    "lets-go-pikachu",
    "lets-go-eevee",
    "sword",
    "shield",
    "the-isle-of-armor",
    "the-crown-tundra",
    "brilliant-diamond",
    "shining-pearl",
    "legends-arceus",
    "scarlet",
    "violet",
    "the-teal-mask",
    "the-indigo-disk",
    "red-japan",
    "green-japan",
    "blue-japan",
    "legends-za",
    "mega-dimension"
  ]

class Playthrough < ApplicationRecord
  belongs_to :user
  has_many :teams

  validates :game_version, presence: true
  validates :game_version, inclusion: { in: GAME_VERSIONS, message: "%{value} is not a valid game version" }
end
