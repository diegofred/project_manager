require "rails_helper"

RSpec.describe Project, type: :model do
  it "A valid Project" do
    p = Project.new
    p.name = "A Valid Name"
    p.description = "A simple description"
    expect(p.valid?).to eq true
  end
end
