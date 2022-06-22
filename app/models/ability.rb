class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Add public recipes here
    return unless user.present?

    can :manage, Food, user_id: user.id
    can :manage, Recipe, user_id: user.id
    can :manage, RecipeFood if Recipe.exists?(:recipe_id) && Recipe.find(:recipe_id).user_id == user.id
    return unless user.role? :admin

    can :manage, :all
  end
end
