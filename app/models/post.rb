class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def likes_count
    likes.count
  end

end
