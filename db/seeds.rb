# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

TeamMember.destroy_all
Team.destroy_all
Playthrough.destroy_all
Pokemon.destroy_all
User.destroy_all

pokemons = [
  "Pikachu",
  "Mew",
  "Porygon",
  "Kakuna",
  "Starmie"
]

pokemons.each do |poke|
  Pokemon.create!(name:poke, game_version:"Red", type_1:"Wa")
end

user = User.create!(email:"ash@gmail.com", password:"123123")

pokemon = Pokemon.last
playthrough = Playthrough.create!(user: user, game_version: "Red")
team = Team.create!(name:"Kenji", playthrough: playthrough)
member = TeamMember.create!(team: team, pokemon: pokemon)
