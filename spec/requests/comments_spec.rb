require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let!(:user) {create(:user) }
  let!(:post_record) {create(:post, user: user) }
  let!(:comments) {create_list(:comment, 3,user: user, post: post_record)}

  before do
    sign_in user
  end

  describe 'GET /comments(JSON形式)' do
    it 'JSON形式でcommentsが取得できる' do
      get post_comments_path(post_record),headers: {
        'Accept': 'application/json'
      }
      expect(response).to have_http_status(200)

      body = JSON.parse(response.body)
      expect(body.length).to eq 3
      expect(body[0]['content']).to eq comments.first.content
      expect(body[1]['content']).to eq comments.second.content
      expect(body[2]['content']).to eq comments.third.content
    end
  end

  describe 'POST /comments(JSON形式)' do
    it 'commentが保存できる' do
      post post_comments_path(post_record), params: { comment: { content: 'test comment' } }
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      expect(body['content']).to eq 'test comment'
      expect(Comment.last.content).to eq 'test comment'
    end
  end
end
