FactoryBot.define do
  factory :team do
    user { create(:user) }
    account { create(:account) }
  end
end
