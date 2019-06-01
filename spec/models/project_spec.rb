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
end
