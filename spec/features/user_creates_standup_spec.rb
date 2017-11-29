require 'rails_helper'

RSpec.feature "user creates a standup" do
  scenario "creates a standup inside a team for the user", js: true do
    user = create(:user)
    team = create(:team, name: "Team 1")
    team_user = FactoryGirl.create(:team_user, user: user, team: team)
    login_as(user, scope: :user)

    visit teams_path
    click_on 'Team 1'

    fill_in :standup_body, :with => 'My standup'
    fill_in :standup_blockers_attributes_0_body, with: 'WOW'
    click_link 'Add a blocker'
    fill_in :standup_blockers_attributes_1_body, with: 'Blocked'
    click_button 'Create Standup'

    expect(page).to have_content 'My standup'
    expect(page).to have_content 'WOW'
    expect(page).to have_content 'Blocked'
    expect(page).to_not have_css('.new-standup-form')
  end
end
