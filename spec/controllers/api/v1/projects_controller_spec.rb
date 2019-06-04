require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do
  login_user
  # This should return the minimal set of attributes required to create a valid
  # Project. As you add validations to Project, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { name: 'a Valid name', description: 'Valid Description' }
  end

  let(:invalid_attributes) do
    { name: 'xx', description: nil, user_id: @user.id }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      project = FactoryBot.create(:project, user_id: @user.id)
      get :show, params: { id: project.to_param }
      expect(response).to be_successful
    end

    it 'return a not existing object' do
      project = FactoryBot.create(:project, user_id: @user.id)
      get :show, params: { id: 50_000 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Project' do
        expect do
          post :create, params: { project: valid_attributes }
        end.to change(Project, :count).by(1)
      end

      it 'renders a JSON response with the new project' do
        post :create, params: { project: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new project' do
        post :create, params: { project: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { name: 'changed name', description: 'Changed description' }
      end

      it 'updates the requested project' do
        project = FactoryBot.create(:project, user_id: @user.id)
        put :update, params: { id: project.to_param, project: new_attributes }

        #  expect(response.body)
        body = JSON.parse(response.body)
        expect(body['name']).to eq(new_attributes[:name])
        expect(body['description']).to eq(new_attributes[:description])
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end

      it 'renders a JSON response with the project' do
        project = FactoryBot.create(:project, user_id: @user.id)

        put :update, params: { id: project.to_param, project: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the project' do
        project = FactoryBot.create(:project, user_id: @user.id)

        put :update, params: { id: project.to_param, project: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end

      it 'update a not existing object' do
        project = FactoryBot.create(:project, user_id: @user.id)
        put :update, params: { id: 100_000, project: valid_attributes }
        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested project' do
      project = FactoryBot.create(:project, user_id: @user.id)
      expect do
        delete :destroy, params: { id: project.to_param }
      end.to change(Project, :count).by(-1)
    end

    it 'destroys a not existing object' do
      project = FactoryBot.create(:project, user_id: @user.id)
      expect do
        delete :destroy, params: { id: 10_000 }
      end.to change(Project, :count).by(0)
      expect(response).to have_http_status(:not_found)
    end
  end
end
