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
