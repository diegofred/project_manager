FactoryBot.define do
  factory :project do
    name { "A Project For test" }
    description { "MyText" }
  end

  factory :another_project do
    name { "Another Project For test" }
    description { "A project for test" }
  end
end
