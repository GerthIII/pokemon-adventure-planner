pokemon_filepath = "db/pokemon.json"
serialized_data = File.read(pokemon_filepath)
pokemons_arr = JSON.parse(serialized_data)["data"]

TeamMember.destroy_all
Message.destroy_all
Team.destroy_all
Playthrough.destroy_all
Pokemon.destroy_all
User.destroy_all
# Cria todos os Pokémon do JSON

current_game = pokemons_arr.select do |poke|
  poke["game_version"] == "firered"
end

current_game.each do |poke|
  Pokemon.create!(
    name: poke["name"],
    type_1: poke["types"]&.first || "unknown",
    type_2: poke["types"]&.second,
    game_version: poke["game_version"] )
  end

  user = User.create!(email: "ash@gmail.com", password: "123123")
  playthrough = Playthrough.create!(user: user, game_version: "firered")
  team = Team.create!(name: "Kenji", playthrough: playthrough)
  random_pokemons = Pokemon.all.sample(6)

  random_pokemons.each do |pokemon|
    TeamMember.create!(team: team, pokemon: pokemon)
  end

  puts "#{Pokemon.count} Pokemon created"
  puts "#{Playthrough.count} Playthrough created"
  puts "#{Team.count} Team created"
  puts "#{User.count} User created"
