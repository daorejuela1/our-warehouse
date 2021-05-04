FactoryBot.define do
  factory :user do
    sequence(:name) {|n| "Test#{n}"}
    sequence(:account_name) {|n| "Test#{n}"}
    sequence(:email) {|n| "test#{n}@hotmail.es" }
    password  { "admin12345" }
    password_confirmation  { "admin12345" }
  end
end
