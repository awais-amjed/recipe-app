class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Food
    return unless user.present?

    can :manage, Food, user_id: user.id
    can :manage, Recipe, user_id: user.id
    return unless user.role? :admin

    can :manage, :all
  end
end
