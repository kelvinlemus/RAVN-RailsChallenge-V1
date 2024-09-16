class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include Pundit::Authorization
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :countries, :pokemons

  def countries
    @countries ||= Country.all
  end

  def pokemons
    @pokemons ||= Pokemon.all
  end
end
