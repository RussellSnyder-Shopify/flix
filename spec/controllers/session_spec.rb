require 'rails_helper'

RSpec.describe SessionsController do
  describe 'POST create' do
    it 'creates a session if password is correct' do
      user = FactoryBot.create(:user)

      post :create, params: {
        email_or_username: user.email,
        password: FactoryBot.attributes_for(:user)[:password]
      }

      expect(flash[:alert]).to eq(nil)
      expect(response).to redirect_to(user)
    end

    it 'does not creates a session if password is incorrect' do
      user = FactoryBot.create(:user)

      post :create, params: {
        email_or_username: user.email,
        password: 'random password'
      }

      expect(flash[:alert]).to eq('Invalid email/password combination')
      expect(response).to render_template(:new)
    end
  end
end
