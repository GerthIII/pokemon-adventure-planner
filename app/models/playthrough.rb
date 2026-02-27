class Playthrough < ApplicationRecord
  belongs_to :user
  has_many :teams, dependent: :destroy


  GAME_VERSIONS = [
    "blue",
    "green",
    "red",
    "firered",
    "leafgreen",
    "gold",
    "silver",
    "crystal",
    "heartgold",
    "soulsilver",
    "sapphire",
    "emerald",
    "ruby",
    "omega-ruby",
    "alpha-sapphire",
    "pearl",
    "black",
    "white",
    "black-2",
    "white",
    "white-2",
    "x",
    "y",
    "sun",
    "moon",
    "sword",
    "shield",
    "scarlet",
    "violet",
    "legends-za"
  ]

  validates :game_version, presence: true
  validates :game_version, inclusion: { in: GAME_VERSIONS, message: "%{value} is not a valid game version" }

  def get_starters
    case game_version
    when "blue", "green", "red", "firered", "leafgreen"
      Pokemon.where(name: ["charmander", "bulbasaur", "squirtle"], game_version: game_version)
    when "gold", "silver", "crystal", "heartgold", "soulsilver"
      Pokemon.where(name: ["cyndaquil", "totodile", "chikorita"], game_version: game_version)
    when "sapphire", "emerald", "ruby", "omega-ruby", "alpha-sapphire"
      Pokemon.where(name: ["mudkip", "treecko", "torchic"], game_version: game_version)
    when "pearl", "diamond", "shining-pearl", "brilliant-diamond"
      Pokemon.where(name: ["chimchar", "piplup", "turtwig"], game_version: game_version)
    when "black", "white", "white-2", "black-2"
      Pokemon.where(name: ["oshawott", "snivy", "tepig"], game_version: game_version)
    when "x", "y"
      Pokemon.where(name: ["fennekin", "chespin", "froakie"], game_version: game_version)
    when "sun", "moon"
      Pokemon.where(name: ["litten", "popplio", "rowlett"], game_version: game_version)
    when "sword", "shield"
      Pokemon.where(name: ["scorbunny", "sobble", "grookey"], game_version: game_version)
    when "scarlet", "violet"
      Pokemon.where(name: ["fuecoco", "sprigatito", "quaxly"], game_version: game_version)
    when "legends-arceus"
      Pokemon.where(name: ["cyndaquil", "oshawott", "rowlet"], game_version: game_version)
    when "legends-za"
      Pokemon.where(name: ["chicorita", "tepig", "totodile"], game_version: game_version)
    when 'lets-go-pikachu'
      Pokemon.where(name: "pikachu", game_version: game_version)
    when 'lets-go-eevee'
      Pokemon.where(name: "eevee", game_version: game_version)
    else
      []
    end
  end

end
