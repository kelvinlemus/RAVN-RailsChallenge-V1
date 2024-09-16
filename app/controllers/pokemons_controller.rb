class PokemonsController < ApplicationController
  PER_PAGE = 10

  helper_method :pokemon_types, :countries
  before_action :set_pokemon, only: [ :show, :destroy, :edit, :update ]

  def index
    authorize(Pokemon)

    page = params.fetch(:page, 1).to_i

    @pokemons = Pokemon.includes(:pokemon_type).all
    @pokemons = @pokemons.by_name_or_type(params[:search]) if params[:search].present?

    @pokemons = @pokemons.page(page).per(PER_PAGE)
  end

  def new
    @pokemon = Pokemon.new
    authorize(@pokemon)
  end

  def edit
    authorize(@pokemon)
  end

  def show
    authorize(@pokemon)
  end

  def create
    @pokemon = Pokemon.new(permited_params)
    authorize(@pokemon)

    if @pokemon.save
      redirect_to pokemons_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize(@pokemon)

    if @pokemon.update(permited_params)
      redirect_to pokemons_path
    else
      render :edit
    end
  end

  def destroy
    authorize(@pokemon)

    @pokemon.destroy

    redirect_to pokemons_path
  end

  private

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  end

  def pokemon_types
    @pokemon_types ||= PokemonType.all
  end

  def permited_params
    params.require(:pokemon).permit(:name, :image, :pokemon_type_id, :main_technique, :description, country_ids: [])
  end
end
