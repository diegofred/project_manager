require 'rails_helper'

RSpec.describe Project, type: :model do
  before(:all) do
    @user = FactoryBot.create(:user)
  end

  it 'A valid Project' do
    p = Project.new
    p.name = 'A Valid Name'
    p.description = 'A simple description'
    p.user = @user # An existing user
    expect(p.valid?).to be true
  end

  it 'A invalid project without mandatory fields' do
    p2 = FactoryBot.build(:project, name: '', description: '') # without User ID
    expect(p2.valid?).to eq false
    expect(p2.errors[:name].present?).to be true
    expect(p2.errors[:description].present?).to be true
    expect(p2.errors[:user_id].present?).to be true
  end

  it 'A invalid project with a short name' do
    p3 = FactoryBot.build(:project, name: 'name') # without a short name
    expect(p3.valid?).to eq false
    expect(p3.errors.messages[:name].include?('is too short (minimum is 5 characters)')).to be true
  end




  describe 'Project Name' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(5) }

  end

  describe 'Project Description' do

    it { should validate_presence_of(:description) }
  end

  describe 'Project User' do
    it { should validate_presence_of(:user_id) }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:tasks) }
  end


end
