require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let!(:users) { create_list(:user, 10) }
  let!(:posts){ create_list(:post, 10, user:user)}

  context 'ログインしている場合' do
    before do
      sign_in user
    end

    it 'Post一覧が表示される' do
      visit root_path
      posts.each do |post|
        expect(page).to have_content(post.content)
      end
    end
  end
end
