FactoryBot.define do
  factory :task do
    sequence(:name) { |i| "My Task n #{i}"}
    sequence(:description) { |n| "Description of task n  #{n}" }
    total_hours { 1.5 }
    dead_line { '2019-08-27' }
    priority { 1 }
    project { nil }
  end
end
