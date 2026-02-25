pokemon_filepath = "db/pokemon.json"
serialized_data = File.read(pokemon_filepath)
pokemons_arr = JSON.parse(serialized_data)["data"]

TeamMember.destroy_all
Team.destroy_all
Playthrough.destroy_all
# Pokemon.destroy_all
User.destroy_all


if Pokemon.count < 800
  pokemons_arr.each do |pokemon_hash|
    current_pokemon = Pokemon.create!(name:pokemon_hash["name"], game_version: pokemon_hash["game_version"], type_1: pokemon_hash["types"][0], type_2: pokemon_hash["types"][1])
    puts "#{current_pokemon.name} from #{current_pokemon.game_version} created"
  end
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
