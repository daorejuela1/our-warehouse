FactoryBot.define do
  factory :box do
    account { create(:account, user: create(:user)) }
    sequence(:name) {|n| "Box-#{n}" }
  end
end
