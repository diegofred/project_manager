FactoryBot.define do
  factory :task do
    name { "MyString" }
    text { "" }
    total_hours { 1.5 }
    dead_line { "2019-05-27" }
    priority { 1 }
    project { nil }
  end
end
