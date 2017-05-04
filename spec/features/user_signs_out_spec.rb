require 'rails_helper'

RSpec.feature "user signs out" do
  setup do
    user = FactoryGirl.build(:user)
    login_as(user, :scope => :user)
  end

  scenario "signs out user from their account" do
    visit "/"
    expect(page).to have_content "Logout"
    click_link 'Logout'

    expect(page).to have_content "Register"
    expect(page).to have_content "Login"
  end
end
