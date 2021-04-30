FactoryBot.define do
  factory :account do
    user { create(:user) }
    sequence(:name) { |n| "Company-#{n}"}
  end
end
