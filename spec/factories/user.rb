FactoryGirl.define do
  factory :user do
    session_id Faker::Crypto.sha1
  end
end
