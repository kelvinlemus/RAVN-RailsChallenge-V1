class CreatePokemonCountries < ActiveRecord::Migration[7.2]
  def change
    create_table :pokemon_countries do |t|
      t.references :pokemon, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true
      t.timestamps
    end

    add_index :pokemon_countries, [ :pokemon_id, :country_id ], unique: true
  end
end
