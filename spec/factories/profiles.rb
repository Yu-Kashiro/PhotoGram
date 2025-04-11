FactoryBot.define do
  factory :profile do
    display_name{ Faker::Internet.username }
    introduction{ Faker::Lorem.paragraph }
  end
end
