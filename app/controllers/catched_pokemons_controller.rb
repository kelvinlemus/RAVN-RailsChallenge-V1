class CatchedPokemonsController < ApplicationController
  PER_PAGE = 10

  def index
    authorize(UserPokemon)

    page = params.fetch(:page, 1).to_i

    @user_pokemons = current_user.user_pokemons.page(page).per(PER_PAGE)
  end

  def new
    @user_pokemon = current_user.user_pokemons.new

    authorize(@user_pokemon)
  end

  def create
    permited_params = params.require(:user_pokemon).permit(:pokemon_id, :nickname)
    @user_pokemon = current_user.user_pokemons.new(permited_params)

    authorize(@user_pokemon)

    if @user_pokemon.save
      PokemonMailer.with(user_id: current_user.id, pokemon_id: @user_pokemon.pokemon_id).pokemon_added.deliver_later
      redirect_to catched_pokemons_path
    else
      render :new, status: :unprocessable_entity
    end
  end
end
