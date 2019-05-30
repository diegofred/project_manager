class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end

  def initialize(user, project)
    @user = user
    @project = project
  end

  def update?
    @user.id == @project.user_id
  end

  def destroy?
    @user.id == @project.user_id
  end
end
