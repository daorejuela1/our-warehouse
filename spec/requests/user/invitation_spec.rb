require 'rails_helper'

RSpec.describe "", type: :request do
  describe "POST /user/invitation" do

    it "redirects if user not logged" do
      post "/users/invitation"
      expect(response).to have_http_status(302)
    end

  end

  describe "GET /user/invitation/new" do
    let (:user) {create(:user)}
    it "redirects if user not logged" do
      get "/users/invitation/new"
      expect(response).to have_http_status(302)
    end

    it "success if user is admin" do
      sign_in user
      get "/users/invitation/new"
      expect(response).to have_http_status(200)
    end

    it "redirect if user is not admin" do
      user.account.delete
      sign_in user
      get "/users/invitation/new"
      expect(response).to have_http_status(302)
    end

  end
end
