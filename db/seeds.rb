# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

# User・profileを20人作る
20.times do
  user = User.create!(email: Faker::Internet.email, password: 'password123', account_id: Faker::Internet.username(specifier: 5..8))
  profile = user.build_profile
  profile.display_name = user.account_id
  profile.introduction = 'test introduction'

  avatar_url = "https://picsum.photos/100/100/?random"
  profile.avatar.attach(
    io: URI.open(avatar_url),
    filename: "avatar_#{user.account_id}.jpg",
    content_type: 'image/jpeg'
  )

  profile.save!
end

# randomに5人ずつフォロー
users = User.all
users.each do |user|
  other_users = User.where.not(id: user.id)
  random_users = other_users.order('RANDOM()').limit(5)
  random_users.each do |random_user|
    user.follow!(random_user)
  end
end

# postを2つずつ作成、写真も添付
users.each do |user|
  image_urls = [
  "https://picsum.photos/400/400/?random",
  "https://picsum.photos/400/400/?random"
  ]
  2.times do
    post = user.posts.create!(content: Faker::Lorem.sentence(word_count: 3))
    image_urls.each_with_index do |url, i|
      post.images.attach(
        io: URI.open(url),
        filename: "image#{i + 1}.jpg",
        content_type: 'image/jpeg'
      )
    end
  end
end

# いいねを5つ作成
users.each do |user|
  posts = Post.where.not(user_id: user.id)
  random_posts = posts.order('RANDOM()').limit(5)
  random_posts.each do |random_post|
    user.likes.create!(post_id: random_post.id)
  end
end

# コメントを2つ作成
users.each do |user|
  posts = Post.where.not(user_id: user.id)
  random_posts = posts.order('RANDOM()').limit(2)
  random_posts.each do |random_post|
    user.comments.create!(post_id: random_post.id, content: Faker::Lorem.sentence(word_count: 3))
  end
end
