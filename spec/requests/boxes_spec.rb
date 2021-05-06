require 'rails_helper'

RSpec.describe "Boxes", type: :request do
  describe "GET /show" do
    it "returns http redirect without login" do
      get "/boxes/show"
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET /new" do
    it "returns http redirect without login" do
      get "/boxes/new"
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET /create" do
    it "returns http redirect without login" do
      get "/boxes/create"
      expect(response).to have_http_status(:redirect)
    end
  end

end
