require 'rails_helper'

RSpec.describe Comment, type: :model do
  let (:user) { create(:user)}
  let (:post) { create(:post, user: user)}

  # 成功パターン
  context 'contentが入力されている場合' do
    let (:comment) { build(:comment, user_id: user.id, post_id: post.id) }

    it 'Commentが保存できる' do
      expect(comment).to be_valid
    end
  end

  # 失敗パターン
  context 'contentが入力されていない場合' do
    let (:comment) { build(:comment, user_id: user.id, post_id: post.id, content: nil) }

    it 'Commentが保存できない' do
      expect(comment).to be_invalid
    end
  end
end
