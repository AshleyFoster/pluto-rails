require 'rails_helper'

RSpec.feature "user logs in" do
  scenario "signs user into their account" do
    user = FactoryGirl.create(:user)
    visit "/users/sign_in"

    fill_in 'user_email', :with => user.email
    fill_in 'user_password', :with => user.password
    click_button 'Log in'

    expect(page).to have_content "Logout"
  end
end
