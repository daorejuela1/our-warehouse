require 'rails_helper'

RSpec.describe Item, type: :model do
  let (:item) { build(:item) }
  let (:box) { build(:box) }
  let (:account) { build(:account) }
  let (:user) { build(:user) }
  before do
    box.account = account
    box.user = user
    item.box = box
    ActsAsTenant.current_tenant = item.box.account
    item.save
  end

  it 'saves correctly' do
    expect(item).to be_valid
  end

  it 'Description can not  have special characters' do
    item.description = "Hello!$#"
    expect(item).not_to be_valid
  end

  it 'does save with the same description' do
    item2 = build(:item, description: item.description)
    expect(item).to be_valid
    expect(item2).not_to be_valid
  end
end
