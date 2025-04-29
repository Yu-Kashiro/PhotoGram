require 'rails_helper'

RSpec.describe User, type: :model do
  # 成功パターン
  context 'email・password・account_idが揃っている場合' do
    before do
      @user = User.create(email: Faker::Internet.email,
                        password: 'password',
                        account_id: Faker::Internet.username)
    end

    it 'Userが作成できる' do
      expect(@user).to be_valid
    end
  end

  # 失敗パターン
  context 'email・password・account_idが揃っていない場合' do
    before do
      @user = User.new(email: nil,
                        password: nil,
                        account_id: nil)
      @user.save
    end

    it 'Userの保存に失敗する' do
      expect(@user).to be_invalid
    end
  end
end
