module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_comment, only: %i[show update destroy]
      before_action :authenticate_user!

      # GET /comments
      def index
        @comments = Comment.accessible_by(current_ability).all

        render json: @comments
      end

      # GET /comments/1
      def show
        render json: @comment
      end

      # POST /comments
      def create
        @comment = current_user.comments.build(task_params)(comment_params)

        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /comments/1
      def update
        if @comment.update(comment_params)
          render json: @comment
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      # GET /comments/in_task/:task_id
      def in_task
        @tasks = Task.accessible_by(current_ability).where(task_id: params[:task_id])
        render json: @tasks
      end

      # DELETE /comments/1
      def destroy
        @comment.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_comment
        @comment = Comment.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def comment_params
        params.require(:comment).permit(:description, :attach, :task_id)
      end
    end
  end
end
