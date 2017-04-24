require 'rails_helper'

RSpec.feature "user signs up" do
  scenario "creates an account for the user" do
    user = FactoryGirl.build(:user)
    visit "/users/sign_up"

    fill_in 'user_email', :with => user.email
    fill_in 'user_password', :with => user.password
    fill_in 'user_password_confirmation', :with => user.password_confirmation
    click_button 'Sign up'

    expect(page).to have_content "Welcome! You have signed up successfully."
  end
end
