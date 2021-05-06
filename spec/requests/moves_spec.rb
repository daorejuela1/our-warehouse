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

    it "users is logged in returns http redirection" do
      sign_in user
      get "/item/moves/#{item.id}/edit"
      expect(response).to have_http_status(200)
    end

  end

end
