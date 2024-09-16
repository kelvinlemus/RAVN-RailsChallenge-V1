class Pokemon < ApplicationRecord
  has_many :pokemon_countries, dependent: :destroy
  has_many :countries, through: :pokemon_countries
  has_many :user_pokemons, dependent: :destroy

  belongs_to :pokemon_type

  has_one_attached :image

  validates :name, :pokemon_type_id, presence: true

  scope :by_name_or_type, ->(query) { joins(:pokemon_type).where("UPPER(pokemons.name) LIKE :query OR UPPER(pokemon_types.name) LIKE :query", query: "%#{query.upcase}%") }
end
