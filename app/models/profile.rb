# == Schema Information
#
# Table name: profiles
#
#  id           :bigint           not null, primary key
#  display_name :string           not null
#  introduction :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar

  def display_avatar
    if avatar.attached?
      avatar
    else
      'dummy_profile.png'
    end
  end

end
