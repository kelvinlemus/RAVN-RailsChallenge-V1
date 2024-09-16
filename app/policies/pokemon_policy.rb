class PokemonPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
