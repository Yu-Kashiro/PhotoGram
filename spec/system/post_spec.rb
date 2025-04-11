require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let!(:users) { create_list(:user, 20, :with_profile) }
  let!(:posts) do
    users.flat_map { |user| create_list(:post, 5, user: user) }
  end

  context 'ログインしている、かつ2人フォローしている場合' do
    let(:user) { users.first } # ログインするユーザーを指定
    before do
      users.each do |user|
        other_users = users.reject { |u| u.id == user.id }
        other_users.sample(2).each do |other_user|
          user.follow!(other_user)
        end
      end
      sign_in user
    end

    it 'Post一覧が表示される' do
      visit root_path
      expect(page).to have_css('.post-container', count: 5)
      expect(page).to have_css('.post-image')
    end
  end
end
