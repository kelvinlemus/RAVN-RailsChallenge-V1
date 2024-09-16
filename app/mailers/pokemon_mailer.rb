class PokemonMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def pokemon_added
    @pokemon = Pokemon.find(params[:pokemon_id])
    @user = User.find(params[:user_id])
    mail(to: @user.email, subject: 'Pokemon added')
  end
end