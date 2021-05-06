require 'rails_helper'

RSpec.describe "Accounts", type: :request do

  describe "GET /accounts/edit" do
    let (:user) {create(:user)}
    it "gets the current user when logged" do
      sign_in user
      get "/users/edit"
      expect(response).to have_http_status(200)
    end

    it "gets redirected if not logged" do
      get "/users/edit"
      expect(response).to have_http_status(302)
    end
  end

  describe "PUT /accounts" do
    let (:user) {create(:user)}
    it "not logged dont check valuein returns http redirection" do
      new_attributes = {selected_tenant: user.account.name}
      put "/accounts/1", params: { user: new_attributes  }
      expect(response).to have_http_status(302)
    end

    it "users is logged in returns http redirection" do
      sign_in user
      new_attributes = {name: "gabriel"}
      put "/accounts/2", params: { account: new_attributes  }
      expect(response).to have_http_status(302)
      expect(user.account.name).to eq("gabriel")
    end

  end

end
