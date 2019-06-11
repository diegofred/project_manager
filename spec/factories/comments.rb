FactoryBot.define do
  factory :comment do
    sequence(:description) { |i| "My comment #{i}" }
    task { nil }
  end
end
