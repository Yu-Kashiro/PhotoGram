require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let (:user) { create(:user)}
  let! (:posts) { create_list(:post, 10, user: user)}

  describe 'GET /posts' do
    it 'ログインしていない場合、302ステータスが返ってくる' do
      get posts_path
      expect(response).to have_http_status(302)
    end

    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '200ステータスが返ってくる' do
        get posts_path
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /posts' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it 'postが保存できる' do
        image = fixture_file_upload(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpeg')
        post_params = attributes_for(:post)
        post_params[:images] = [image]
        post posts_path, params: {post: post_params}
        expect(response).to have_http_status(302)
        expect(Post.last.content).to eq(post_params[:content])
      end
    end

    context 'ログインしていない場合' do
      it 'リダイレクトされる' do
        image = fixture_file_upload(Rails.root.join('spec/fixtures/files/test_image.jpg'), 'image/jpeg')
        post_params = attributes_for(:post)
        post_params[:images] = [image]
        post posts_path, params: {post: post_params}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end
