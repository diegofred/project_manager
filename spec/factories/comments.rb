FactoryBot.define do
  factory :comment do
    sequence(:description) { |i| "My comment #{i}" }
    attach { "MyString" }
    task { nil }
  end
end
