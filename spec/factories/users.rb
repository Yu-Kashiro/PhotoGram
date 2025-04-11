FactoryBot.define do
  factory :user do
    email{Faker::Internet.email}
    password{'password'}
    account_id{Faker::Internet.username}

    trait :with_profile do
      after :build do |user|
        build(:profile, user: user)
      end
    end
  end
end
