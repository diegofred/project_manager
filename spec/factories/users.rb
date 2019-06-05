FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "test_user_#{i}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    name { 'Test User' }
  end
end
