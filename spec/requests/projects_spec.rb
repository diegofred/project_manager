require 'rails_helper'

RSpec.describe 'Projects', type: :request do
<<<<<<< HEAD
  context 'context: request via API' do
    include_context 'session_api'
    before(:each) do
      @current_user = FactoryBot.create(:user)
      @project = FactoryBot.create(:project, user_id: @current_user.id)
    end

    describe 'GET /api/v1/projects' do
      it 'works! (now write some real specs)' do
        login
        auth_params = get_auth_params_from_login_response_headers(response)
        get api_v1_projects_path, headers: auth_params
        expect(response).to have_http_status(200)
      end
=======
  include_context 'session_api'
  before(:each) do
    @current_user = FactoryBot.create(:user)
    @project = FactoryBot.create(:project, user_id: @current_user.id)
  end
  describe 'GET /api/v1/projects' do
    it 'works! (now write some real specs)' do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      get api_v1_projects_path, headers: auth_params
      expect(response).to have_http_status(200)
>>>>>>> 17c922e3a3ed8b4b19bcc268507202a33c64726c
    end
  end
end
