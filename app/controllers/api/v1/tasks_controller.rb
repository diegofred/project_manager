module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_task, only: %i[show update destroy]
      before_action :authenticate_user!
      # GET /tasks
      def index
        @tasks = Task.all
        render json: @tasks
      end

      # GET /tasks/1
      def show
        render json: @task
      end

      # POST /tasks
      def create
        @project = Project.find(params[:task][:project_id])
        @task = current_user.tasks.build(task_params)
        if @task.save
          render json: @task, status: :created
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /tasks/1
      def update
        authorize @task, :update?
        if @task.update(task_params)
          render json: @task
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      # GET /tasks/in_project/:project_id
      def in_project
       # byebug
        @project = Project.includes(:tasks => [:comments] ).find(params[:project_id])
        render json: @project, include: :tasks
      end

      # DELETE /tasks/1
      def destroy
        authorize @task, :destroy?
        @task.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_task
        @task = Task.find(params[:id])
      end

      def set_task_to_done
        authorize @task, :update?
        @task = Task.find(params[:id])
        if task.done?
          task.done!
          render json: @task
        else
          render json: { status: 'This taks has already been done' }, status: :unprocessable_entity
        end
      end

      # Only allow a trusted parameter "white list" through.
      def task_params
        params.require(:task).permit(:name, :description, :text, :total_hours, :dead_line, :priority, :project_id)
      end
    end
  end
end
