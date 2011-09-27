class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Account if user.role == "admin"
    can :manage, User if user.role == "admin"
  end
end
