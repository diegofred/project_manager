require 'rails_helper'


RSpec.describe "Tasks", type: :request do
  describe "GET /api/v1/tasks" do
    it "works! (now write some real specs)" do
      get api_v1_tasks_path
      expect(response).to have_http_status(200)
    end
  end
end
