# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           not null
#  encrypted_password     :string           not null
#  account_id             :string           not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Relationship', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  validates :email, presence: true, uniqueness: true
  validates :account_id, presence: true, uniqueness: true

  def follow!(user)
    following_relationships.create!(following_id: user.id)
  end

  def unfollow!(user)
    following_relationships.find_by!(following_id: user.id).destroy
  end

  def has_followed?(user)
    followings.exists?(user.id)
  end

  def has_liked?(post)
    likes.exists?(post_id: post.id)
  end

  def prepare_profile
    if profile
      profile
    else
      profile = build_profile
      profile.display_name = account_id
      profile.save
      profile
    end
  end

  def followings_posts
    Post.where(user_id: followings.pluck(:id)).order(created_at: :desc)
  end

end
