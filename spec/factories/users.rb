FactoryBot.define do
  factory :user do
    email{Faker::Internet.email}
    password{'password'}
    account_id{Faker::Internet.username}
  end
end
