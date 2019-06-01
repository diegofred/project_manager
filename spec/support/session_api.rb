require 'rails_helper'


RSpec.shared_context 'session_api', shared_context: :metadata do
  def login
    post user_session_path, params: { email: @current_user.email, password: 'password' }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
  end

  def get_auth_params_from_login_response_headers(response)
    client = response.headers['client']
    token = response.headers['access-token']
    expiry = response.headers['expiry']
    token_type = response.headers['token-type']
    uid = response.headers['uid']

    auth_params = {
      'access-token' => token,
      'client' => client,
      'uid' => uid,
      'expiry' => expiry,
      'token_type' => token_type
    }
    auth_params
  end
end

RSpec.configure do |rspec|
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
  rspec.include_context 'session_api', include_shared: true
end
