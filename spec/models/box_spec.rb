require 'rails_helper'

RSpec.describe Box, type: :model do
  describe '#Validations' do
    let (:box) { build(:box) }
    let (:user) { create(:user) }

    before do
      ActsAsTenant.current_tenant = box.account
      box.user = box.account.user
    end

    it 'saves correctly' do
      expect(box).to be_valid
    end

    it 'name can contain weird characters' do
      box.name = "Hello !$#"
      expect(box).to be_valid
    end

    it 'does not save with the same name' do
      box = create(:box, name: "Box-1", user: user)
      box2 = build(:box, name: "Box-1", user: user)
      box.user = box.account.user
      box2.user = box.account.user
      expect(box).to be_valid
      expect(box2).not_to be_valid
    end
  end
end
