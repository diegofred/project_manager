class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      can :manage, Project, user_id: user.id
      can :manage, Tasks, user_id: user.id
      can :manage, Comments, user_id: user.id
    end
  end
end
