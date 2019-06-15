require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  login_user
  # This should return the minimal set of attributes required to create a valid
  # Task. As you add validations to Task, be sure to
  # adjust the attributes here as well.
  before(:each) do
    @project = FactoryBot.create(:project, user_id: @user.id)
  end
  let(:valid_attributes) do
    { name: 'Test Task', description: 'A simple description', total_hours: 3, priority: 6, dead_line: '2019-08-27' }
  end

  let(:invalid_attributes) do
    { name: '', description: 'A simple description', total_hours: -1, priority: 6, dead_line: '2019-08-27' }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #in_project' do
    it 'returns a success response' do
      get :in_project, params: { project_id: @project.id }
      expect(response).to be_successful
    end

    it 'Correct reponse data format' do
      5.times { |_t| FactoryBot.create(:task, project_id: @project.id, user_id: @user.id) }
      get :in_project, params: { project_id: @project.id }
      expect(response).to be_successful
      expect(response.content_type).to eq('application/json')
      body = JSON.parse(response.body)
      expect(body['tasks'].count).to eq(5)
    end

    it 'returns a not found response' do
      get :in_project, params: { project_id: 50_000 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      task = FactoryBot.create(:task, project_id: @project.id, user_id: @user.id)
      get :show, params: { id: task.to_param }
      expect(response).to be_successful
    end

    it 'returns a not_found response' do
      task = FactoryBot.create(:task, project_id: @project.id, user_id: @user.id)
      get :show, params: { id: 50_000 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Task' do
        expect do
          post :create, params: { task: valid_attributes.merge(project_id: @project.id) }
        end.to change(Task, :count).by(1)
      end

      it 'renders a JSON response with the new task' do
        post :create, params: { task: valid_attributes.merge(project_id: @project.id) }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new task' do
        post :create, params: { task: invalid_attributes.merge(project_id: @project.id) }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { name: 'Test Task Edited', description: 'A simple description Edited', total_hours: 20, priority: 7, dead_line: '2019-08-28' }
      end

      it 'updates the requested task' do
        task = FactoryBot.create(:task, project_id: @project.id, user_id: @user.id)
        put :update, params: { id: task.to_param, task: new_attributes }
        body = JSON.parse(response.body)
        expect(body['name']).to eq(new_attributes[:name])
        expect(body['description']).to eq(new_attributes[:description])
        expect(body['total_hours']).to eq(new_attributes[:total_hours])
        expect(body['priority']).to eq(new_attributes[:priority])
        expect(body['dead_line']).to eq(new_attributes[:dead_line])
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end

      it 'renders a JSON response with the task' do
        task = FactoryBot.create(:task, project_id: @project.id, user_id: @user.id)
        put :update, params: { id: task.to_param, task: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the task' do
        task = FactoryBot.create(:task, project_id: @project.id, user_id: @user.id)
        put :update, params: { id: task.to_param, task: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end

      it 'returns a not_found response' do
        task = FactoryBot.create(:task, project_id: @project.id, user_id: @user.id)
        put :update, params: { id: 50_000, task: invalid_attributes }
        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested task' do
      task = FactoryBot.create(:task, project_id: @project.id, user_id: @user.id)
      expect do
        delete :destroy, params: { id: task.to_param }
      end.to change(Task, :count).by(-1)
    end

    it 'returns a not_found response' do
      task = FactoryBot.create(:task, project_id: @project.id, user_id: @user.id)
      expect do
        delete :destroy, params: { id: 50_000 }
      end.to change(Task, :count).by(0)
      expect(response).to have_http_status(:not_found)
    end
  end
end
