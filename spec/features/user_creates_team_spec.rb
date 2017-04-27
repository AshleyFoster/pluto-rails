require 'rails_helper'

RSpec.feature "user creates a team" do
  scenario "creates a team for the user" do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit "/teams/new"

    fill_in 'Name', :with => 'Team'
    click_button 'Create Team'

    expect(page).to have_content 'Team created!'
  end
end
