require 'rails_helper'


RSpec.describe Api::V1::CommentsController, type: :controller do
  login_user
  before(:each) do
    @project = FactoryBot.create(:project, user_id: @user.id)
    @task = FactoryBot.create(:task, user_id: @user.id, project_id: @project.id)
  end
  # This should return the minimal set of attributes required to create a valid
  # Comment. As you add validations to Comment, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {:description => 'A valid comment'}
  end

  let(:invalid_attributes) do
    {:description => nil}
  end


  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      comment = FactoryBot.create(:comment, task_id: @task.id, user_id: @user.id)
      get :show, params: { id: comment.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Comment' do
        expect do
          post :create, params: { comment: valid_attributes.merge({task_id: @task.id}) }
        end.to change(Comment, :count).by(1)
      end

      it 'renders a JSON response with the new comment' do
        post :create, params: { comment: valid_attributes.merge({task_id: @task.id}) }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new comment' do
        post :create, params: { comment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {:description => "new Description"}
      end

      it 'updates the requested comment' do
        comment = FactoryBot.create(:comment, task_id: @task.id, user_id: @user.id)
        put :update, params: { id: comment.to_param, comment: new_attributes }
        comment.reload
        expect(comment.description).to eq(new_attributes[:description])
        expect(response).to have_http_status(:ok)
      end

      it 'renders a JSON response with the comment' do
        comment = FactoryBot.create(:comment, task_id: @task.id, user_id: @user.id)

        put :update, params: { id: comment.to_param, comment: valid_attributes.merge({task_id: @task.id}) }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the comment' do
        comment = FactoryBot.create(:comment, task_id: @task.id, user_id: @user.id)

        put :update, params: { id: comment.to_param, comment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested comment' do
      comment = FactoryBot.create(:comment, task_id: @task.id, user_id: @user.id)
      expect do
        delete :destroy, params: { id: comment.to_param }
      end.to change(Comment, :count).by(-1)
    end
  end
end
