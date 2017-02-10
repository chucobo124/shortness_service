FactoryGirl.define do
  factory :shortener do
    url Faker::Internet.url
    unique_key Faker::Code.asin
    label Faker::App.name
    string Faker::Name.name
    expires_at Faker::Date.forward(23)
    user
  end
end
