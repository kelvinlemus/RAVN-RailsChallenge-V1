class CreatePokemons < ActiveRecord::Migration[7.2]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.references :pokemon_type, null: false, foreign_key: true
      t.string :main_technique
      t.text :description
      t.timestamps
    end
  end
end
