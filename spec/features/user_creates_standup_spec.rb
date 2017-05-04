require 'rails_helper'

RSpec.feature "user creates a standup" do
  scenario "creates a standup inside a team for the user" do
    user = create(:user)
    team = create(:team, name: "Team 1", user: user)
    login_as(user, scope: :user)

    visit teams_path
    click_on 'Team 1'

    fill_in :standup_body, :with => 'My standup'
    click_button 'Create Standup'

    expect(page).to have_content 'My standup'
    expect(page).to have_content 'Archer'
    expect(page).to_not have_css('.new-standup-form')
  end
end
