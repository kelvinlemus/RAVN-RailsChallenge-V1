class CreateUserPokemons < ActiveRecord::Migration[7.2]
  def change
    create_table :user_pokemons do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pokemon, null: false, foreign_key: true
      t.string :nickname
      t.timestamps
    end

    add_index :user_pokemons, [ :user_id, :pokemon_id ], unique: true
  end
end
