require 'rails_helper'

describe User do
  describe 'admin?' do
    it 'returns false if user is not Admin' do
      user = FactoryBot.build(:user)

      expect(user.admin?).to eq(false)
    end
    it 'returns true if user is Admin' do
      user = FactoryBot.build(:admin)

      expect(user.admin?).to eq(true)
    end
  end

  describe 'super_admin?' do
    it 'returns false if user is not Admin' do
      user = FactoryBot.build(:user)

      expect(user.super_admin?).to eq(false)
    end
    it 'returns false if Admin is not SuperAdmin' do
      user = FactoryBot.build(:admin)

      expect(user.super_admin?).to eq(false)
    end
    it 'returns true if SuperAdmin' do
      user = FactoryBot.build(:super_admin)

      expect(user.super_admin?).to eq(true)
    end
  end
end
