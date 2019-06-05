class CommentPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        scope.where(user_id: user.id)
      end
    end
  
    def initialize(user, comment)
      @user = user
      @comment = comment
    end
  
    def update?
      @user.id == @comment.user_id
    end
  
    def destroy?
      @user.id == @comment.user_id
    end
  end
  