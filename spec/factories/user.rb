FactoryGirl.define do
  factory :user do
    session_id Faker::Crypto.sha1
    user_agent 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0'
    ip_address Faker::Internet.ip_v4_address
  end
end
