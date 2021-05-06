require 'rails_helper'

RSpec.describe "Tenants", type: :request do
  describe "PUT /user/tenants" do
    let (:account) {create(:account)}
    let (:user) {create(:user)}

    it "not logged in  in returns http redirection" do
      new_attributes = {selected_tenant: account.name}
      put "/user/tenants", params: { user: new_attributes  }
      expect(response).to have_http_status(302)
    end

    it "users is logged in returns http redirection" do
      sign_in user
      new_attributes = {selected_tenant: account.name}
      put "/user/tenants", params: { user: new_attributes  }
      expect(response).to have_http_status(302)
    end

  end

end
