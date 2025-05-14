# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :post_id, :avatar_url, :account_id

  def avatar_url
    comment_user = User.find(object.user_id)
    host = Rails.application.config.host_name
    if comment_user.profile.avatar.attached?
      Rails.application.routes.url_helpers.rails_blob_url(comment_user.profile.avatar, host: host)
    else
      ActionController::Base.helpers.asset_url('dummy_profile.png', host: host)
    end
  end

  def account_id
    comment_user = User.find(object.user_id)
    comment_user.account_id
  end

end
