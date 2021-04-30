FactoryBot.define do
  factory :user do
    name { "Test"}
    email { "test@hotmail.es" }
    password  { "admin12345" }
    password_confirmation  { "admin12345" }
  end
end
