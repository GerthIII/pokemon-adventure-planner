# db/seeds.rb

require "json"

puts "Cleaning database..."

TeamMember.destroy_all
Team.destroy_all
Playthrough.destroy_all
Pokemon.destroy_all
User.destroy_all

puts "Creating user..."
user = User.create!(
  email: "ash@gmail.com",
  password: "123123"
)

puts "Loading pokemons from JSON..."

pokemon_filepath = Rails.root.join("db/pokemon.json")
serialized_data = File.read(pokemon_filepath)
pokemons_arr = JSON.parse(serialized_data)["data"]

pokemons_arr.each do |pokemon|
  Pokemon.create!(
    name: pokemon["name"],
    pokedex_id: pokemon["id"],
    sprite_url: pokemon["sprites"]["front_default"]
  )
end

puts "Creating playthrough..."

playthrough = Playthrough.create!(
  user: user,
  game_version: "red" # ← 小文字にすること！！
)

puts "Creating team..."

team = Team.create!(
  name: "Team Rocket",
  playthrough: playthrough
)

puts "Adding first pokemon to team..."

TeamMember.create!(
  team: team,
  pokemon: Pokemon.first
)

puts "Seeding done!"
