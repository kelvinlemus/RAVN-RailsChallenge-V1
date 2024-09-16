class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def create?
    user.admin?
  end

  def show?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      return [] unless @user.admin?

      @scope.trainers
    end

    private

    attr_reader :user, :scope
  end
end
