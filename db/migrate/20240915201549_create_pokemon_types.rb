class CreatePokemonTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :pokemon_types do |t|
      t.string :name
      t.string :color_hex
      t.timestamps
    end
  end
end
