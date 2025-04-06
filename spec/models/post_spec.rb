require 'rails_helper'

RSpec.describe Post, type: :model do
  let (:user) { create(:user)}

  context 'User,images,contentが用意されている場合' do
    let (:post) { build(:post, user: user)}

    it 'postが保存できる' do
      expect(post).to be_valid
      expect(post.images).to be_attached
    end
  end

  context 'contentが用意されていない場合' do
    let (:post) { build(:post, user: user, content: nil)}

    before do
      post.save
    end

    it 'postが保存できない' do
      expect(post.errors.messages[:content][0]).to eq("can't be blank")
    end
  end
end
