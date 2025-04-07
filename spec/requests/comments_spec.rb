require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let!(:user) {create(:user) }
  let!(:post) {create(:post, user: user) }
  let!(:comments) {create_list(:comment, 3,user: user, post: post)}

  describe 'GET /comments(JSON形式)' do
    it '200 Status' do
      get post_comments_path(post),headers: {
        'Accept': 'application/json'
      }
      expect(response).to have_http_status(200)

      body = JSON.parse(response.body)
      binding.pry
      expect(body.length).to eq 3
      expect(body[0]['content']).to eq comments.first.content
      expect(body[1]['content']).to eq comments.second.content
      expect(body[2]['content']).to eq comments.third.content
    end
  end
end
