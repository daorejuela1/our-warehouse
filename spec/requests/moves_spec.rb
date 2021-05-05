require 'rails_helper'

RSpec.describe "Moves", type: :request do
  describe "GET /get" do
    it "returns http success" do
      get "/moves/get"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/moves/update"
      expect(response).to have_http_status(:success)
    end
  end

end
