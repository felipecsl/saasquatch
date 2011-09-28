class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user
    can :manage, Account if user.role == "admin"
    can :manage, User if user.role == "admin"
  end
end
