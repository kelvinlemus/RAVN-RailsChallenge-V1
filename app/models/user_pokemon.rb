class UserPokemon < ApplicationRecord
  belongs_to :user
  belongs_to :pokemon

  validates :pokemon_id, presence: true
  validates :user_id, uniqueness: { scope: :pokemon_id }

  def pokemon_with_nickname
    return pokemon.name if nickname.blank?

    "#{pokemon.name} (#{nickname})"
  end

  def created_at_format
    created_at.strftime("%Y-%m-%d")
  end
end
