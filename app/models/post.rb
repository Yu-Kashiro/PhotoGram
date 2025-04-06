# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord
  validates :content, presence: true, length: { minimum: 10 }
  validates :images, presence: true, length: { minimum: 1, maximum: 5 }

  belongs_to :user
  has_many_attached :images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def likes_count
    likes.count
  end

end
