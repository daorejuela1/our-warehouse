Pay.setup do |config|
  config.business_name = "OWH"
  config.business_address = "1600 Pennsylvania Avenue NW"
  config.application_name = "Our Warehouse"
  config.support_email = "support@our-warehouse.com"
  StripeEvent.signing_secret = ENV['STRIPE_SIGNING_SECRET']
end
