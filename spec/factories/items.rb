FactoryBot.define do
  factory :item do
    description { "Awesome and not unique description" }
    picture { Rack::Test::UploadedFile.new('app/assets/images/Logo.png', 'image/png') }
  end
end
