require 'rails_helper'

RSpec.describe "Moves", type: :request do
  describe "GET /item/moves/:id/edit" do
    let (:item) { build(:item) }
    let (:box) { build(:box) }
    let (:account) { build(:account) }
    let (:user) { create(:user) }
    before do
      account.user = user
      account.save
      ActsAsTenant.current_tenant = account
      box.account = account
      box.user = user
      item.box = box
      box.save
      item.save
    end


    it "not logged in returns http redirection" do
      get "/item/moves/1/edit"
      expect(response).to have_http_status(302)
    end

    it "users is logged in can access information" do
      sign_in user
      get "/item/moves/#{item.id}/edit"
      expect(response).to have_http_status(200)
    end

    it "users is logged but item is in another account cant access information" do
      sign_in user
      item2 = build(:item)
      account2 = build(:account)
      user2 = create(:user)
      account2.user = user2
      account2.save
      ActsAsTenant.current_tenant = account2
      box2 = build(:box, account: account2, user: user2)
      box2.save
      item2.box = box2
      item2.save
      get "/item/moves/#{item2.id}/edit"
      expect(response).to have_http_status(302)
    end

    it "users is logged but item is in user team can access information" do
      sign_in user
      item2 = build(:item)
      account2 = build(:account)
      user2 = create(:user)
      account2.user = user2
      account2.save
      user.join_team!(account2.id)
      ActsAsTenant.current_tenant = account2
      box2 = build(:box, account: account2, user: user2)
      box2.save
      item2.box = box2
      item2.save
      get "/item/moves/#{item2.id}/edit"
      expect(response).to have_http_status(200)
    end

    describe "PUT /item/moves/:id/edit" do
      let (:item) { build(:item) }
      let (:box) { build(:box) }
      let (:account) { build(:account) }
      let (:user) { create(:user) }
      before do
        account.user = user
        account.save
        ActsAsTenant.current_tenant = account
        box.account = account
        box.user = user
        item.box = box
        box.save
        item.save
      end
      it 'cant change item from box to another account' do 
        sign_in user
        item2 = build(:item)
        account2 = build(:account)
        user2 = create(:user)
        account2.user = user2
        account2.save
        user.join_team!(account2.id)
        ActsAsTenant.current_tenant = account2
        box2 = build(:box, account: account2, user: user2)
        box2.save
        item2.box = box2
        item2.save
        new_attributes = {box: box.name}
        put "/item/moves/#{item2.id}", params: { item: new_attributes   }
        expect(response).to have_http_status(302)
      end
    end
  end
end
