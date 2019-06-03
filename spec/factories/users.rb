FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "test_user_#{i}@example.com" }
    password { 'password' }
  end
end
