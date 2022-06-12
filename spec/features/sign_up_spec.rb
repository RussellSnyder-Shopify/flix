require 'rails_helper'

RSpec.describe 'Sign Up', type: :system do
  it 'navigates to Sign Up page from header click' do
    visit root_path

    click_link('Sign Up')

    expect(page).to have_current_path(signup_path)
  end
  describe 'Success' do
    it 'creates user if form is filled correctly' do
      visit signup_path

      fill_in 'user[name]', with: 'Test'
      fill_in 'user[username]', with: 'Test'
      fill_in 'user[email]', with: 'test@test.com'
      fill_in 'user[password]', with: 'passwordpassword'
      fill_in 'user[password_confirmation]', with: 'passwordpassword'

      click_on 'Create Account'

      user = User.find_by(name: 'Test')

      expect(page).to have_current_path(user_path(user))
    end
  end

  describe 'Failure' do
    it 'shows error message if form is filled incorrectly' do
      visit signup_path

      fill_in 'user[name]', with: 'invalid test'
      fill_in 'user[username]', with: 'Test'
      fill_in 'user[email]', with: 'invalid_test@test.com'
      fill_in 'user[password]', with: 'passwordpassword'
      fill_in 'user[password_confirmation]', with: 'passwordpassword1'

      click_on 'Create Account'

      user = User.find_by(name: 'invalid test')

      expect(user).to eq(nil)
      expect(page).to have_selector 'section#errors', text: "Password confirmation doesn't match Password"
    end
  end
end
