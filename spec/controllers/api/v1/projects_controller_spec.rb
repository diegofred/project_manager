require 'rails_helper'



  RSpec.describe Api::V1::ProjectsController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Project. As you add validations to Project, be sure to
  # adjust the attributes here as well.

  login_user

  let(:valid_attributes) {
    #{name: "a Valid name", description: 'Valid Description'}
    skip('Add a hash of attributes valid for your model')
  }

  let(:invalid_attributes) {
    #{name: "xx", description: nil}
     #{name: "a Valid name", description: 'Valid Description'}
     skip('Add a hash of attributes valid for your model')
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProjectsController. Be sure to keep this updated too.
  let(:valid_session) { {



  } }

  describe "GET #index" do
    it "returns a success response" do
      valid_attributes
     # project = FactoryBot.create(:project,:user_id =>user.id)
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      project = Project.create! valid_attributes
      get :show, params: {id: project.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Project" do
        expect {
          post :create, params: {project: valid_attributes}, session: valid_session
        }.to change(Project, :count).by(1)
      end

      it "renders a JSON response with the new project" do

        post :create, params: {project: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(project_url(Project.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new project" do

        post :create, params: {project: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested project" do
        project = Project.create! valid_attributes
        put :update, params: {id: project.to_param, project: new_attributes}, session: valid_session
        project.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the project" do
        project = Project.create! valid_attributes

        put :update, params: {id: project.to_param, project: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the project" do
        project = Project.create! valid_attributes

        put :update, params: {id: project.to_param, project: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested project" do
      project = Project.create! valid_attributes
      expect {
        delete :destroy, params: {id: project.to_param}, session: valid_session
      }.to change(Project, :count).by(-1)
    end
  end
end
