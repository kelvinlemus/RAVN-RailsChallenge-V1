countries = [
  { name: "Kanto" },
  { name: "Johto" },
  { name: "Hoenn" },
  { name: "Sinnoh" },
  { name: "Unova" },
  { name: "Alola" },
  { name: "Kalos" },
  { name: "Galar" }
]

countries.each do |country|
  Country.find_or_create_by!(name: country[:name])
end

User.create!(email: 'admin@example.com', password: 'password123', password_confirmation: 'password123', role: 'admin')
User.create!(first_name: "Trainer", last_name: "Test", email: 'trainer@example.com', password: 'password123', password_confirmation: 'password123', role: 'trainer')

pokemon_types = [
  { name: "Normal", color_hex: "#A8A77A" },
  { name: "Fire", color_hex: "#EE8130" },
  { name: "Water", color_hex: "#6390F0" },
  { name: "Electric", color_hex: "#F7D02C" },
  { name: "Grass", color_hex: "#7AC74C" },
  { name: "Ice", color_hex: "#96D9D6" },
  { name: "Fighting", color_hex: "#C22E28" },
  { name: "Poison", color_hex: "#A33EA1" },
  { name: "Ground", color_hex: "#E2BF65" },
  { name: "Flying", color_hex: "#A98FF3" },
  { name: "Psychic", color_hex: "#F95587" },
  { name: "Bug", color_hex: "#A6B91A" },
  { name: "Rock", color_hex: "#B6A136" },
  { name: "Ghost", color_hex: "#735797" },
  { name: "Dragon", color_hex: "#6F35FC" },
  { name: "Dark", color_hex: "#705746" },
  { name: "Steel", color_hex: "#B7B7CE" },
  { name: "Fairy", color_hex: "#D685AD" }
]

pokemon_types.each do |type|
  PokemonType.find_or_create_by!(name: type[:name], color_hex: type[:color_hex])
end


pokemons = [
  { name: "Bulbasaur", pokemon_type: "Grass", country: "Kanto" },
  { name: "Charmander", pokemon_type: "Fire", country: "Kanto" },
  { name: "Squirtle", pokemon_type: "Water", country: "Kanto" },
  { name: "Pikachu", pokemon_type: "Electric", country: "Kanto" },
  { name: "Chikorita", pokemon_type: "Grass", country: "Johto" },
  { name: "Cyndaquil", pokemon_type: "Fire", country: "Johto" },
  { name: "Totodile", pokemon_type: "Water", country: "Johto" },
  { name: "Treecko", pokemon_type: "Grass", country: "Hoenn" },
  { name: "Torchic", pokemon_type: "Fire", country: "Hoenn" },
  { name: "Mudkip", pokemon_type: "Water", country: "Hoenn" },
  { name: "Turtwig", pokemon_type: "Grass", country: "Sinnoh" },
  { name: "Chimchar", pokemon_type: "Fire", country: "Sinnoh" },
  { name: "Piplup", pokemon_type: "Water", country: "Sinnoh" },
  { name: "Snivy", pokemon_type: "Grass", country: "Unova" },
  { name: "Tepig", pokemon_type: "Fire", country: "Unova" },
  { name: "Oshawott", pokemon_type: "Water", country: "Unova" },
  { name: "Chespin", pokemon_type: "Grass", country: "Kalos" },
  { name: "Fennekin", pokemon_type: "Fire", country: "Kalos" },
  { name: "Froakie", pokemon_type: "Water", country: "Kalos" },
  { name: "Rowlet", pokemon_type: "Grass", country: "Alola" },
  { name: "Litten", pokemon_type: "Fire", country: "Alola" },
  { name: "Popplio", pokemon_type: "Water", country: "Alola" },
  { name: "Grookey", pokemon_type: "Grass", country: "Galar" },
  { name: "Scorbunny", pokemon_type: "Fire", country: "Galar" },
  { name: "Sobble", pokemon_type: "Water", country: "Galar" }
]

pokemons.each do |pokemon|
  country = Country.find_by(name: pokemon[:country])
  pokemon_type = PokemonType.find_by(name: pokemon[:pokemon_type])
  p = Pokemon.find_or_create_by!(name: pokemon[:name], pokemon_type_id: pokemon_type.id)
  p.country_ids = [ country.id ]
end

countries = Country.all
25.times do |i|
  User.create!(
    first_name: "Trainer #{i + 1}",
    last_name: "Test",
    email: "trainer#{i + 1}@example.com",
    password: 'password123',
    password_confirmation: 'password123',
    role: 'trainer',
    country_id: countries.sample.id
  )
end
