module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :set_project, only: %i[show update destroy]
      before_action :authenticate_user!
      # GET /projects
      def index
        @projects = current_user.projects
        render json: { status: 'SUCCESS', message: 'Loaded Projecs', data: @projects }
      end

      # GET /projects/1
      def show
        render json: { status: 'SUCCESS', message: 'Loaded Projec', data: @projects }
      end

      # POST /projects
      def create
        @project = current_user.projects.build(project_params)
        if @project.save
          render json: @project, status: :created
        else
          render json: @project.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /projects/1
      def update
        authorize @project, :update?
        if @project.update(project_params)
          render json: @project
        else
          render json: @project.errors, status: :unprocessable_entity
        end
      end

      # DELETE /projects/1
      def destroy
        authorize @project, :destroy?
        @project.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_project
        @project = Project.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def project_params
        params.require(:project).permit(:name, :description)
      end
    end
  end
end
