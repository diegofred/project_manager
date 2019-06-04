require 'rails_helper'

RSpec.describe Comment, type: :model do

  describe 'Tasks User' do
    it { should validate_presence_of(:user_id) }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:task) }
  end
end
