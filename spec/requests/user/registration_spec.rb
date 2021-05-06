require 'rails_helper'

RSpec.describe "", type: :request do
  describe "GET /users/sign_up" do
    let (:user) {create(:user)}
    it "success if user not logged" do
      get "/users/sign_up"
      expect(response).to have_http_status(200)
    end

    it "redirects if user is logged in" do
      sign_in user
      get "/users/sign_up"
      expect(response).to have_http_status(302)
    end
  end

  describe "Test stripe error handling" do

    it "mocks a declined card error" do
      StripeMock.prepare_card_error(:card_declined)
      expect { Stripe::Charge.create(amount: 1, currency: 'usd') }.to raise_error {|e|
        expect(e).to be_a Stripe::CardError
        expect(e.http_status).to eq(402)
        expect(e.code).to eq('card_declined')
      }
    end

    it "generates a stripe card token correctly" do
      card_token = StripeMock.generate_card_token(last4: "9191", exp_year: 1984)
      cus = Stripe::Customer.create(source: card_token)
      card = cus.sources.data.first
      expect(card.last4).to eq("9191")
      expect(card.exp_year).to eq(1984)
    end
  end
end
