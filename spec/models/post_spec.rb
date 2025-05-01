require 'rails_helper'

RSpec.describe Post, type: :model do
  let (:user) { create(:user)}

  # 成功パターン
  context 'User,images,contentが用意されている場合' do
    let (:post) { build(:post, user: user)}

    it 'postが保存できる' do
      expect(post).to be_valid
      expect(post.images).to be_attached
    end
  end

  # 失敗パターン
  context 'contentが0文字の場合' do
    let (:post) { build(:post, user: user, content: '')}

    before do
      post.save
    end

    it 'postが保存できない' do
      expect(post.errors.messages[:content][0]).to eq("can't be blank")
    end
  end

  context 'contentが101文字の場合' do
    let (:post) { build(:post, user: user, content: Faker::Lorem.characters(number: 101))}

    before do
      post.save
    end

    it 'postが保存できない' do
      expect(post.errors.messages[:content][0]).to eq("is too long (maximum is 100 characters)")
    end
  end

  context 'imagesが空の場合' do
    before do
      @post = user.posts.build(content: Faker::Lorem.sentence(word_count: 5))
      @post.save
    end

    it 'postが保存できない' do
      expect(@post.errors.messages[:images][0]).to eq("can't be blank")
      expect(@post.errors.messages[:images][1]).to eq("is too short (minimum is 1 character)")
    end
  end

  context 'imagesが5枚の場合' do
    before do
      @post = user.posts.build(content: Faker::Lorem.sentence(word_count: 5))
      5.times do
        @post.images.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
          filename: 'test_image.jpg',
          content_type: 'image/jpeg'
        )
      end
      @post.save
    end

    it 'postが保存できない' do
      expect(@post.errors.messages[:images][0]).to eq("is too long (maximum is 4 characters)")
    end
  end

end
