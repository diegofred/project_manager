require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  login_user
  # This should return the minimal set of attributes required to create a valid
  # Task. As you add validations to Task, be sure to
  # adjust the attributes here as well.
  before(:each) do
    @project = FactoryBot.create(:project, user_id: @user.id)
  end
  let(:valid_attributes) {
    {name: 'Test Task', description: 'A simple description', total_hours:3, priority:6, dead_line: '2019-08-27'}
  }

  let(:invalid_attributes) {
    {name: '', description: 'A simple description', total_hours:-1, priority:6, dead_line: '2019-08-27'}
  }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      task = FactoryBot.create(:task,project_id: @project.id,user_id: @user.id)
      get :show, params: {id: task.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Task" do
        expect {
          post :create, params: {task: valid_attributes.merge({project_id: @project.id})}
        }.to change(Task, :count).by(1)
      end

      it "renders a JSON response with the new task" do
        post :create, params: {task: valid_attributes.merge({project_id: @project.id} )}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new task" do
        post :create, params: {task: invalid_attributes.merge({project_id: @project.id})}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {name: 'Test Task Edited', description: 'A simple description Edited', total_hours:20, priority:7, dead_line: '2019-08-28'}
      }

      it "updates the requested task" do
        task = FactoryBot.create(:task,:project_id => @project.id, user_id: @user.id)
        put :update, params: {id: task.to_param, task: new_attributes}
        body = JSON.parse(response.body)
        expect(body['name']).to eq(new_attributes[:name])
        expect(body['description']).to eq(new_attributes[:description])
        expect(body['total_hours']).to eq(new_attributes[:total_hours])
        expect(body['priority']).to eq(new_attributes[:priority])
        expect(body['dead_line']).to eq(new_attributes[:dead_line])
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end

      it "renders a JSON response with the task" do
        task = FactoryBot.create(:task,:project_id => @project.id, user_id: @user.id)
        put :update, params: {id: task.to_param, task: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the task" do
        task = FactoryBot.create(:task,:project_id => @project.id, user_id: @user.id)
        put :update, params: {id: task.to_param, task: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested task" do
      task = FactoryBot.create(:task,:project_id => @project.id, user_id: @user.id)
      expect {
        delete :destroy, params: {id: task.to_param}
      }.to change(Task, :count).by(-1)
    end
  end

end
