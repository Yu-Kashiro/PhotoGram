FactoryBot.define do
  factory :comment do
    user_id { user.id }
    post_id { post.id }
    content { Faker::Lorem.sentence(word_count: 3) }
  end
end
