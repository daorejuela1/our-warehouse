require 'rails_helper'

RSpec.describe "Uses", type: :request do
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
      post "/item/uses"
      expect(response).to have_http_status(302)
    end

    it "users is logged in can access information" do
      sign_in user
      post "/item/uses", params: { item_id: item.id}
      expect(user.items[0]).to eq(item)
    end

    describe "DELETE /item/uses/:id" do
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

      it 'it redirects if user is not logged in' do 
        delete "/item/uses/#{item.id}"
        expect(response).to have_http_status(302)
      end

      it 'deletes from user items' do 
        sign_in user
        user.items.append(item)
        user.save
        delete "/item/uses/#{item.id}"
        expect(user.items).to be_empty
      end
    end
  end
end
