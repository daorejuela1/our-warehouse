require 'rails_helper'

RSpec.describe "Accounts", type: :request do

  describe "GET /account/edit" do
    let (:user) {create(:user)}
    it "gets the current user when logged" do
      sign_in user
      get "/account/edit"
      expect(response).to have_http_status(200)
    end

    it "gets redirected if not logged" do
      get "/account/edit"
      expect(response).to have_http_status(302)
    end
  end

  describe "PUT /account" do
    let (:user) {create(:user)}
    it "not logged dont check valuein returns http redirection" do
      new_attributes = {selected_tenant: user.account.name}
      put "/account", params: { user: new_attributes  }
      expect(response).to have_http_status(302)
    end

    it "users is logged in returns http redirection" do
      sign_in user
      new_attributes = {name: "gabriel"}
      put "/account", params: { account: new_attributes  }
      expect(response).to have_http_status(302)
      expect(user.account.name).to eq("gabriel")
    end

  end

end
