require 'rails_helper'

RSpec.describe "Billings", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/billing"
      expect(response).to have_http_status(:redirect)
    end
  end

end
