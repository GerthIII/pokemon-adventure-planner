pokemon_filepath = "db/pokemon.json"
serialized_data = File.read(pokemon_filepath)
pokemons_arr = JSON.parse(serialized_data)["data"]

TeamMember.destroy_all
Team.destroy_all
Playthrough.destroy_all
# Pokemon.destroy_all
User.destroy_all


pokemons.each do |poke|
  Pokemon.create!(name:poke, type_1: "fire", game_version: "Red")
end

user = User.create!(email:"ash@gmail.com", password:"123123")
random_pokemons = Pokemon.all.sample(6)

pokemon = Pokemon.last

playthrough = Playthrough.create!(user: user, game_version: "red")
team = Team.create!(id:1, name:"Kenji", playthrough: playthrough)
random_pokemons.each do |pokemon|
 TeamMember.create!(team: team, pokemon: pokemon)
end

puts "#{Pokemon.count} Pokemon created"
puts "#{Playthrough.count} Playthrough created"
puts "#{Team.count} Team created"
puts "#{User.count} User created"
