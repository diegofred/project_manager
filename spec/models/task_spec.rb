require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Task Name' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(5) }
  end

  describe 'Tasks Description' do
    it { should validate_presence_of(:description) }
  end

  describe 'Tasks User' do
    it { should validate_presence_of(:user_id) }
  end

  describe 'Tasks Total Hours' do
    it { should_not allow_value(-3).for(:total_hours) }
    it { should_not allow_value(0).for(:total_hours) }
    it { should allow_value(500).for(:total_hours) }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
    it { should have_many(:comments) }
  end

  end

