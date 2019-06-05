class TaskPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        scope.where(user_id: user.id)
      end
    end
  
    def initialize(user, task)
      @user = user
      @task = task
    end
  
    def update?
      @user.id == @task.user_id
    end
  
    def destroy?
       @user.id == @task.user_id
    end
  end
  