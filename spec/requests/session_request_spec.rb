# I've called it authentication_test_spec.rb and placed it in the spec/requests folder
require 'rails_helper'

# The authentication header looks something like this:
# {"access-token"=>"abcd1dMVlvW2BT67xIAS_A", "token-type"=>"Bearer", "client"=>"LSJEVZ7Pq6DX5LXvOWMq1w", "expiry"=>"1519086891", "uid"=>"darnell@konopelski.info"}

describe 'Whether access is ocurring properly', type: :request do
  include_context 'session_api'
  before(:each) do
    @current_user = FactoryBot.create(:user)
    @project = FactoryBot.create(:project, user_id: @current_user.id)
  end

  context 'context: general authentication via API, ' do
    it "doesn't give you anything if you don't log in" do
      get api_v1_project_path(@project)
      expect(response.status).to eq(401)
    end

    it 'gives you a status 200 on sign in in ' do
      login
      expect(response.status).to eq(200)
    end

    it 'gives you an authentication code if you are an existing user and you satisfy the password' do
      login
      expect(response.has_header?('access-token')).to eq(true)
    end

    it 'first get a token, then access a restricted page' do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      get in_project_api_v1_tasks_path(@project.id), headers: auth_params
      expect(response).to have_http_status(:success)
    end

    it 'deny access to a restricted page with an incorrect token' do
      login
      auth_params = get_auth_params_from_login_response_headers(response).tap do |h|
        h.each do |k, _v|
          h[k] = '123' if k == 'access-token'
        end
      end
      get api_v1_project_path(@project.id), headers: auth_params
      expect(response).not_to have_http_status(:success)
    end
  end
end
