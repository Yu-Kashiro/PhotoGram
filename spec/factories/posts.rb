FactoryBot.define do
  factory :post do
    content { Faker::Lorem.sentence(word_count: 5) }

    after(:build) do |post|
      post.images.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
        filename: 'test_image.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
